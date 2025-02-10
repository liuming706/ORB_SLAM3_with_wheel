# * Try to find libusb1
#
# libusb1_FOUND - system has libusb1 libusb1_INCLUDE_DIRS - the libusb1 include
# directories libusb1_LIBRARIES - link these to use libusb1

find_path(
  libusb1_INCLUDE_DIRS
  NAMES libusb-1.0/libusb.h
  PATHS c:/dev/sysroot32/usr/include ${CMAKE_SOURCE_DIR}/../libusb1/include
        /usr/include/ /usr/local/include /opt/local/include)

find_library(
  libusb1_LIBRARIES
  NAMES usb-1.0
  PATHS c:/dev/sysroot32/usr/lib ${CMAKE_SOURCE_DIR}/../libusb1/lib /usr/lib
        /usr/lib64 /usr/local/lib /opt/local/lib)

if(libusb1_INCLUDE_DIRS AND libusb1_LIBRARIES)
  set(libusb1_FOUND TRUE)
endif(libusb1_INCLUDE_DIRS AND libusb1_LIBRARIES)

if(libusb1_FOUND)
  if(NOT libusb1_FIND_QUIETLY)
    message(STATUS "Found libusb1: ${libusb1_LIBRARIES}")
  endif(NOT libusb1_FIND_QUIETLY)
else(libusb1_FOUND)
  message(STATUS "libusb1 NOT found")
  if(libusb1_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find libusb1")
  endif(libusb1_FIND_REQUIRED)
endif(libusb1_FOUND)
