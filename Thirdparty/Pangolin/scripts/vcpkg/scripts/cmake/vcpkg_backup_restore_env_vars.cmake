function(vcpkg_backup_env_variables)
  cmake_parse_arguments(PARSE_ARGV 0 arg "" "" "VARS")
  if(NOT DEFINED arg_VARS)
    message(FATAL_ERROR "VARS must be defined.")
  endif()
  if(DEFINED arg_UNPARSED_ARGUMENTS)
    message(
      FATAL_ERROR
        "${CMAKE_CURRENT_FUNCTION} was passed extra arguments: ${arg_UNPARSED_ARGUMENTS}"
    )
  endif()

  foreach(envvar IN LISTS arg_VARS)
    if(DEFINED ENV{${envvar}})
      set("z_vcpkg_env_backup_${envvar}"
          "$ENV{${envvar}}"
          PARENT_SCOPE)
    else()
      unset("z_vcpkg_env_backup_${envvar}" PARENT_SCOPE)
    endif()
  endforeach()
endfunction()

function(vcpkg_restore_env_variables)
  cmake_parse_arguments(PARSE_ARGV 0 arg "" "" "VARS")
  if(NOT DEFINED arg_VARS)
    message(FATAL_ERROR "VARS must be defined.")
  endif()
  if(DEFINED arg_UNPARSED_ARGUMENTS)
    message(
      FATAL_ERROR
        "${CMAKE_CURRENT_FUNCTION} was passed extra arguments: ${arg_UNPARSED_ARGUMENTS}"
    )
  endif()

  foreach(envvar IN LISTS arg_VARS)
    if(DEFINED z_vcpkg_env_backup_${envvar})
      set("ENV{${envvar}}" "${z_vcpkg_env_backup_${envvar}}")
    else()
      unset("ENV{${envvar}}")
    endif()
  endforeach()
endfunction()
