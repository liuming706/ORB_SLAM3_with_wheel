function(z_vcpkg_translate_to_host_path_list out_var lst)
  if(NOT DEFINED arg_UNPARSED_ARGUMENTS)
    set("${out_var}"
        ""
        PARENT_SCOPE)
  else()
    if("${VCPKG_HOST_PATH_SEPARATOR}" STREQUAL ";")
      set("${out_var}"
          "${lst}"
          PARENT_SCOPE)

      string(FIND "${lst}" [[\;]] index_of_host_path_separator)
    else()
      vcpkg_list(JOIN lst "${VCPKG_HOST_PATH_SEPARATOR}" arguments)
      set("${out_var}"
          "${arguments}"
          PARENT_SCOPE)

      string(FIND "${lst}" "${VCPKG_HOST_PATH_SEPARATOR}"
                  index_of_host_path_separator)
    endif()
    if(NOT "${index_of_host_path_separator}" EQUAL "-1")
      message(
        FATAL_ERROR
          "Host path separator (${VCPKG_HOST_PATH_SEPARATOR}) in path; this is unsupported."
      )
    endif()
  endif()
endfunction()

function(vcpkg_host_path_list)
  if("${ARGC}" LESS "2")
    message(FATAL_ERROR "vcpkg_host_path_list requires at least two arguments.")
  endif()

  if("${ARGV1}" MATCHES
     "^ARGV([0-9]*)$|^ARG[CN]$|^CMAKE_CURRENT_FUNCTION|^CMAKE_MATCH_")
    message(
      FATAL_ERROR
        "vcpkg_host_path_list does not support the list_var being ${ARGV1}.
    Please use a different variable name.")
  endif()

  if("${ARGV1}" MATCHES [[^ENV\{(.*)\}$]])
    set(list "$ENV{${CMAKE_MATCH_1}}")
    set(env_var ON)
  elseif("${ARGV1}" MATCHES [[^([A-Z]+)\{.*\}$]])
    message(
      FATAL_ERROR
        "vcpkg_host_path_list does not support ${CMAKE_MATCH_1} variables;
    only ENV{} and regular variables are supported.")
  else()
    set(list "${${ARGV1}}")
    set(env_var OFF)
  endif()
  set(operation "${ARGV0}")
  set(list_var "${ARGV1}")

  cmake_parse_arguments(PARSE_ARGV 2 arg "" "" "")
  z_vcpkg_translate_to_host_path_list(arguments "${arg_UNPARSED_ARGUMENTS}")

  if("${operation}" STREQUAL "SET")
    set(list "${arguments}")
  elseif("${operation}" MATCHES "^(APPEND|PREPEND)$")
    if("${arguments}" STREQUAL "")
      # do nothing
    elseif("${list}" STREQUAL "")
      set(list "${arguments}")
    elseif("${operation}" STREQUAL "PREPEND")
      set(list "${arguments}${VCPKG_HOST_PATH_SEPARATOR}${list}")
    else()
      set(list "${list}${VCPKG_HOST_PATH_SEPARATOR}${arguments}")
    endif()
  else()
    message(FATAL_ERROR "Operation ${operation} not recognized.")
  endif()

  if(env_var)
    set("${list_var}" "${list}")
  else()
    set("${list_var}"
        "${list}"
        PARENT_SCOPE)
  endif()
endfunction()
