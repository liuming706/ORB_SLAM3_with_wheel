# Process the libs and targets in the variable named by `input` into a flat list
# of libs in the variable named by `output`. Simplify -framework elements. Use
# -l where possible. Avoid duplicates.
function(vcpkg_curl_flatten input output)
  set(output_libs "${${output}}")
  if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    string(REGEX REPLACE ";optimized;[^;]*|;debug" "" input_libs
                         "VCPKG;${${input}}")
  else()
    string(REGEX REPLACE ";debug;[^;]*|;optimized" "" input_libs
                         "VCPKG;${${input}}")
  endif()
  list(REMOVE_AT input_libs 0)
  while(input_libs)
    list(POP_BACK input_libs lib)
    if(TARGET "${lib}")
      set(import_lib "")
      set(import_location "")
      get_target_property(type "${lib}" TYPE)
      if(NOT type STREQUAL "INTERFACE_LIBRARY")
        if(CMAKE_BUILD_TYPE STREQUAL "Debug")
          get_target_property(link_libs "${lib}"
                              IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG)
          get_target_property(import_lib "${lib}" IMPORTED_IMPLIB_DEBUG)
          get_target_property(import_location "${lib}" IMPORTED_LOCATION_DEBUG)
        else()
          get_target_property(link_libs "${lib}"
                              IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE)
          get_target_property(import_lib "${lib}" IMPORTED_IMPLIB_RELEASE)
          get_target_property(import_location "${lib}"
                              IMPORTED_LOCATION_RELEASE)
        endif()
        if(link_libs)
          vcpkg_curl_flatten(link_libs output_libs)
        endif()
        get_target_property(link_libs "${lib}"
                            IMPORTED_LINK_INTERFACE_LIBRARIES)
        if(link_libs)
          vcpkg_curl_flatten(link_libs output_libs)
        endif()
        if(NOT import_lib)
          get_target_property(import_lib "${lib}" IMPORTED_IMPLIB)
        endif()
        if(NOT import_location)
          get_target_property(import_location "${lib}" IMPORTED_LOCATION)
        endif()
      endif()
      get_target_property(link_libs "${lib}" INTERFACE_LINK_LIBRARIES)
      if(link_libs)
        vcpkg_curl_flatten(link_libs output_libs)
      endif()
      if(import_lib)
        set(lib "${import_lib}")
      elseif(import_location)
        set(lib "${import_location}")
      endif()
    endif()
    if(lib MATCHES "^(.*)/([^/]*)[.]framework$")
      if(CMAKE_MATCH_1 IN_LIST CMAKE_C_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES)
        set(lib "-framework ${CMAKE_MATCH_2}")
      else()
        set(lib "-framework ${lib}")
      endif()
    elseif(
      WIN32
      AND lib
          MATCHES
          ".*/${CMAKE_IMPORT_LIBRARY_PREFIX}([^/]*)${CMAKE_IMPORT_LIBRARY_SUFFIX}"
    )
      set(lib -l${CMAKE_MATCH_1})
    elseif(
      lib MATCHES
      ".*/${CMAKE_STATIC_LIBRARY_PREFIX}([^/]*)${CMAKE_STATIC_LIBRARY_SUFFIX}")
      set(lib -l${CMAKE_MATCH_1})
    endif()
    if(NOT "${lib}" IN_LIST output_libs)
      list(PREPEND output_libs "${lib}")
    endif()
  endwhile()
  set("${output}"
      "${output_libs}"
      PARENT_SCOPE)
endfunction()

if(CURL_USE_LIBSSH2)
  find_package(Libssh2 CONFIG REQUIRED)
  set(LIBSSH2_FOUND TRUE)
  get_target_property(LIBSSH2_INCLUDE_DIR Libssh2::libssh2
                      INTERFACE_INCLUDE_DIRECTORIES)
  set(LIBSSH2_LIBRARY Libssh2::libssh2)
endif()

if(USE_LIBIDN2)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(LIBIDN2 REQUIRED libidn2)
endif()
