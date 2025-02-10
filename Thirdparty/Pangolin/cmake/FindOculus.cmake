# * Try to find Oculus Rift SDK
#
# Oculus_FOUND - system has libuvc Oculus_INCLUDE_DIRS - the libuvc include
# directories Oculus_LIBRARIES - link these to use libuvc

find_path(
  Oculus_INCLUDE_DIRS
  NAMES OVR.h
  PATHS ${CMAKE_SOURCE_DIR}/../LibOVR/Include
        ${CMAKE_SOURCE_DIR}/../OculusSDK/LibOVR/Include
        /usr/include/LibOVR/Include
        /usr/local/include/LibOVR/Include
        /opt/local/include/LibOVR/Include
        /usr/include/
        /usr/local/include
        /opt/local/include)

find_library(
  Oculus_LIBRARIES
  NAMES ovr
  PATHS ${CMAKE_SOURCE_DIR}/../LibOVR/Lib/MacOS/Release
        ${CMAKE_SOURCE_DIR}/../OculusSDK/LibOVR/Lib/Linux/Release/x86_64
        /usr/include/LibOVR/Lib
        /usr/local/include/LibOVR/Lib
        /opt/local/include/LibOVR/Lib
        /usr/lib
        /usr/local/lib
        /opt/local/lib)

if(Oculus_INCLUDE_DIRS AND Oculus_LIBRARIES)
  if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    find_library(CARBON_LIBRARIES NAMES Carbon)
    find_library(IOKIT_LIBRARIES NAMES IOKit)
    list(APPEND Oculus_LIBRARIES ${CARBON_LIBRARIES})
    list(APPEND Oculus_LIBRARIES ${IOKIT_LIBRARIES})
    set(Oculus_FOUND TRUE)
  elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    find_package(Xrandr QUIET)
    if(Xrandr_FOUND)
      list(APPEND Oculus_LIBRARIES ${Xrandr_LIBRARIES} -ludev -lXrandr
           -lXinerama)
      set(Oculus_FOUND TRUE)
    endif()
  endif()
endif(Oculus_INCLUDE_DIRS AND Oculus_LIBRARIES)

if(Oculus_FOUND)
  if(NOT Oculus_FIND_QUIETLY)
    message(STATUS "Found Oculus: ${Oculus_LIBRARIES}")
    message(STATUS "Found Oculus: ${Oculus_INCLUDE_DIRS}")
  endif(NOT Oculus_FIND_QUIETLY)
else(Oculus_FOUND)
  message(STATUS "Oculus NOT found")
  if(Oculus_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find Oculus")
  endif(Oculus_FIND_REQUIRED)
endif(Oculus_FOUND)
