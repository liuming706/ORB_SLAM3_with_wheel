# * Try to find uvc
#
# uvc_FOUND - system has libuvc uvc_INCLUDE_DIRS - the libuvc include
# directories uvc_LIBRARIES - link these to use libuvc

find_path(
  uvc_INCLUDE_DIRS
  NAMES libuvc/libuvc.h
  PATHS ${CMAKE_SOURCE_DIR}/.. /usr/include/ /usr/local/include
        /opt/local/include)

find_library(
  uvc_LIBRARIES
  NAMES uvc
  PATHS ${CMAKE_SOURCE_DIR}/../uvc/build /usr/lib /usr/local/lib /opt/local/lib)

if(uvc_INCLUDE_DIRS AND uvc_LIBRARIES)
  set(uvc_FOUND TRUE)
endif(uvc_INCLUDE_DIRS AND uvc_LIBRARIES)

if(uvc_FOUND)
  if(NOT uvc_FIND_QUIETLY)
    message(STATUS "Found uvc: ${uvc_LIBRARIES}")
  endif(NOT uvc_FIND_QUIETLY)
else(uvc_FOUND)
  if(uvc_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find uvc")
  endif(uvc_FIND_REQUIRED)
endif(uvc_FOUND)
