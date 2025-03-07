if(NOT DEFINED Z_VCPKG_OVERRIDEN_EXECUTE_PROCESS)
  set(Z_VCPKG_OVERRIDEN_EXECUTE_PROCESS ON)

  if(DEFINED VCPKG_DOWNLOAD_MODE)
    function(execute_process)
      message(
        FATAL_ERROR
          "This command cannot be executed in Download Mode.\nHalting portfile execution.\n"
      )
    endfunction()
    set(Z_VCPKG_EXECUTE_PROCESS_NAME "_execute_process")
  else()
    set(Z_VCPKG_EXECUTE_PROCESS_NAME "execute_process")
  endif()
endif()
