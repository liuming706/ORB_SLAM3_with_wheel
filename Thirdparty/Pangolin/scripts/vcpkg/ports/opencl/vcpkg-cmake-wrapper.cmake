_find_package(${ARGS})
if(NOT BUILD_SHARED_LIBS AND (NOT CMAKE_SYSTEM_NAME MATCHES "Darwin"))
  find_package(Threads REQUIRED)
  set(OpenCL_Extra_Libs ${CMAKE_DL_LIBS} ${CMAKE_THREAD_LIBS_INIT})
  if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    list(APPEND OpenCL_Extra_Libs cfgmgr32)
    if($ENV{WindowsSDKVersion} MATCHES "^10")
      list(APPEND OpenCL_Extra_Libs OneCoreUAP)
    endif()
  endif(CMAKE_SYSTEM_NAME MATCHES "Windows")

  if(TARGET OpenCL::OpenCL)
    set_property(
      TARGET OpenCL::OpenCL
      APPEND
      PROPERTY INTERFACE_LINK_LIBRARIES ${OpenCL_Extra_Libs})
  endif()
  if(OpenCL_LIBRARIES)
    list(APPEND OpenCL_LIBRARIES ${OpenCL_Extra_Libs})
  endif()
endif()
