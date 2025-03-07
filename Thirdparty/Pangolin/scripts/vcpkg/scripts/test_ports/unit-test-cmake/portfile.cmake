function(set_fatal_error err)
  set(Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR
      "ON"
      CACHE BOOL "" FORCE)
  set(Z_VCPKG_UNIT_TEST_FATAL_ERROR
      "${err}"
      CACHE STRING "" FORCE)
endfunction()
function(unset_fatal_error)
  set(Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR
      "OFF"
      CACHE BOOL "" FORCE)
endfunction()
function(set_has_error)
  set(Z_VCPKG_UNIT_TEST_HAS_ERROR
      ON
      CACHE BOOL "" FORCE)
endfunction()

macro(message level msg)
  if("${level}" STREQUAL "FATAL_ERROR")
    set_fatal_error("${msg}")
    return()
  else()
    _message("${level}" "${msg}") # note: this results in incorrect printing,
                                  # but that's fine
    # message(STATUS "\${asdf}") will result in message(STATUS "${asdf}"), since
    # that's how macro arguments work.
  endif()
endmacro()

set(Z_VCPKG_UNIT_TEST_HAS_ERROR
    OFF
    CACHE BOOL "" FORCE)
unset_fatal_error()

# in order to allow namespacing
function(unit_test_match namespace value regex)
  if("${value}" MATCHES "${regex}")
    set("${namespace}_MATCHED"
        ON
        PARENT_SCOPE)
    if("${CMAKE_MATCH_COUNT}" EQUAL "0")
      return()
    endif()

    foreach(match RANGE 1 "${CMAKE_MATCH_COUNT}")
      set("${namespace}_CMAKE_MATCH_${match}"
          "${CMAKE_MATCH_${match}}"
          PARENT_SCOPE)
    endforeach()
  else()
    set("${namespace}_MATCHED"
        OFF
        PARENT_SCOPE)
  endif()
endfunction()

function(unit_test_check_variable_unset utcvu_test utcvu_variable)
  cmake_language(EVAL CODE "${utcvu_test}")
  if(Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR)
    unset_fatal_error()
    set_has_error()
    message(STATUS "${utcvu_test} had an unexpected FATAL_ERROR;
    expected: \"${utcvu_value}\"")
    message(STATUS "FATAL_ERROR: ${Z_VCPKG_UNIT_TEST_FATAL_ERROR}")
    return()
  endif()

  unit_test_match(utcvu "${utcvu_variable}" [[^(ENV|CACHE)\{(.*)\}$]])
  if(utcvu_MATCHED)
    message(STATUS "utcvu_variable: ${utcvu_CMAKE_MATCH_2}")
    if("${utcvu_CMAKE_MATCH_1}" STREQUAL "ENV")
      set(utcvu_actual_value "$ENV{${utcvu_CMAKE_MATCH_2}}")
    elseif("${utcvu_CMAKE_MATCH_1}" STREQUAL "CACHE")
      set(utcvu_actual_value "$CACHE{${utcvu_CMAKE_MATCH_2}}")
    else()
      _message(FATAL_ERROR
               "unexpected value for CMAKE_MATCH_1: ${utcvu_CMAKE_MATCH_1}")
    endif()
  else()
    set(utcvu_actual_value "${${utcvu_variable}}")
  endif()

  if(DEFINED "${utcvu_variable}")
    message(STATUS "${utcvu_test} set ${utcvu_variable};
    expected: \"${utcvu_variable}\" unset
    actual  : \"${utcvu_actual_value}\"")
    set_has_error()
    return()
  endif()
endfunction()

function(unit_test_check_variable_equal utcve_test utcve_variable utcve_value)
  cmake_language(EVAL CODE "${utcve_test}")
  if(Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR)
    unset_fatal_error()
    set_has_error()
    message(STATUS "${utcve_test} had an unexpected FATAL_ERROR;
    expected: \"${utcve_value}\"")
    message(STATUS "FATAL_ERROR: ${Z_VCPKG_UNIT_TEST_FATAL_ERROR}")
    return()
  endif()

  if(NOT DEFINED "${utcve_variable}" AND NOT "${utcve_variable}" MATCHES
                                         "^ENV\\{")
    message(STATUS "${utcve_test} failed to set ${utcve_variable};
    expected: \"${utcve_value}\"")
    set_has_error()
    return()
  endif()

  unit_test_match(utcve "${utcve_variable}" [[^(ENV|CACHE)\{(.*)\}$]])
  if(utcve_MATCHED)
    if("${utcve_CMAKE_MATCH_1}" STREQUAL "ENV")
      set(utcve_actual_value "$ENV{${utcve_CMAKE_MATCH_2}}")
    elseif("${utcve_CMAKE_MATCH_1}" STREQUAL "CACHE")
      set(utcve_actual_value "$CACHE{${utcve_CMAKE_MATCH_2}}")
    else()
      _message(FATAL_ERROR
               "unexpected value for CMAKE_MATCH_1: ${utcve_CMAKE_MATCH_1}")
    endif()
  else()
    set(utcve_actual_value "${${utcve_variable}}")
  endif()

  if(NOT "${utcve_actual_value}" STREQUAL "${utcve_value}")
    message(
      STATUS "${utcve_test} resulted in the wrong value for ${utcve_variable};
    expected: \"${utcve_value}\"
    actual  : \"${utcve_actual_value}\"")
    set_has_error()
    return()
  endif()
endfunction()

function(unit_test_check_variable_not_equal utcve_test utcve_variable
         utcve_value)
  cmake_language(EVAL CODE "${utcve_test}")
  if(Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR)
    unset_fatal_error()
    set_has_error()
    message(STATUS "${utcve_test} had an unexpected FATAL_ERROR;
    expected: \"${utcve_value}\"")
    message(STATUS "FATAL_ERROR: ${Z_VCPKG_UNIT_TEST_FATAL_ERROR}")
    return()
  endif()

  unit_test_match(utcve "${utcve_variable}" [[^(ENV|CACHE)\{(.*)\}$]])
  if(utcve_MATCHED)
    if("${utcve_CMAKE_MATCH_1}" STREQUAL "ENV")
      set(utcve_actual_value "$ENV{${utcve_CMAKE_MATCH_2}}")
    elseif("${utcve_CMAKE_MATCH_1}" STREQUAL "CACHE")
      set(utcve_actual_value "$CACHE{${utcve_CMAKE_MATCH_2}}")
    else()
      _message(FATAL_ERROR
               "unexpected value for CMAKE_MATCH_1: ${utcve_CMAKE_MATCH_1}")
    endif()
  else()
    set(utcve_actual_value "${${utcve_variable}}")
  endif()

  if("${utcve_actual_value}" STREQUAL "${utcve_value}")
    message(STATUS "${utcve_test} failed to change ${utcve_variable};
    unchanged: \"${utcve_value}\"")
    set_has_error()
    return()
  endif()
endfunction()

function(unit_test_ensure_success utcve_test)
  cmake_language(EVAL CODE "${utcve_test}")
  if(Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR)
    set_has_error()
    message(STATUS "${utcve_test} was expected to be successful.")
  endif()
  unset_fatal_error()
endfunction()
function(unit_test_ensure_fatal_error utcve_test)
  cmake_language(EVAL CODE "${utcve_test}")
  if(NOT Z_VCPKG_UNIT_TEST_HAS_FATAL_ERROR)
    set_has_error()
    message(STATUS "${utcve_test} was expected to be a FATAL_ERROR.")
  endif()
  unset_fatal_error()
endfunction()

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

if("minimum-required" IN_LIST FEATURES)
  include("${CMAKE_CURRENT_LIST_DIR}/test-vcpkg_minimum_required.cmake")
endif()
if("list" IN_LIST FEATURES)
  include("${CMAKE_CURRENT_LIST_DIR}/test-vcpkg_list.cmake")
endif()
if("host-path-list" IN_LIST FEATURES)
  include("${CMAKE_CURRENT_LIST_DIR}/test-vcpkg_host_path_list.cmake")
endif()
if("function-arguments" IN_LIST FEATURES)
  include("${CMAKE_CURRENT_LIST_DIR}/test-z_vcpkg_function_arguments.cmake")
endif()
if("merge-libs" IN_LIST FEATURES)
  include(
    "${CMAKE_CURRENT_LIST_DIR}/test-z_vcpkg_cmake_config_fixup_merge.cmake")
endif()
if("backup-restore-env-vars" IN_LIST FEATURES)
  include("${CMAKE_CURRENT_LIST_DIR}/test-vcpkg_backup_restore_env_vars.cmake")
endif()
if("setup-pkgconfig-path" IN_LIST FEATURES)
  include("${CMAKE_CURRENT_LIST_DIR}/test-z_vcpkg_setup_pkgconfig_path.cmake")
endif()

if(Z_VCPKG_UNIT_TEST_HAS_ERROR)
  _message(FATAL_ERROR "At least one test failed")
endif()
