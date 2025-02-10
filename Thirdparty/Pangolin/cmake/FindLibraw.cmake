# * Try to find libraw
#
# libraw_FOUND - system has libraw libraw_INCLUDE_DIRS - the libraw include
# directories libraw_LIBRARIES - link these to use libraw

find_path(
  libraw_INCLUDE_DIRS
  NAMES libraw/libraw.h
  PATHS ${LIBRAW_DIR} ${LIBRAW_DIR}/include /usr/include/ /usr/local/include
        /opt/local/include)

find_library(
  libraw_LIBRARIES
  NAMES raw_r
  PATHS ${LIBRAW_DIR} ${LIBRAW_DIR}/lib /usr/lib /usr/local/lib /opt/local/lib)

if(libraw_INCLUDE_DIRS AND libraw_LIBRARIES)
  set(libraw_FOUND TRUE)
endif(libraw_INCLUDE_DIRS AND libraw_LIBRARIES)

if(libraw_FOUND)
  if(NOT libraw_FIND_QUIETLY)
    message(STATUS "Found libraw: ${libraw_LIBRARIES}")
  endif(NOT libraw_FIND_QUIETLY)
else(libraw_FOUND)
  if(libraw_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find libraw")
  endif(libraw_FIND_REQUIRED)
endif(libraw_FOUND)
