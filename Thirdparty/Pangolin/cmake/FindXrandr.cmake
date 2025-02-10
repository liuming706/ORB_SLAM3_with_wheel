# * Try to find Xrandr
#
# Xrandr_FOUND - system has libXrandr Xrandr_INCLUDE_DIRS - the libXrandr
# include directories Xrandr_LIBRARIES - link these to use libXrandr

find_path(
  Xrandr_INCLUDE_DIRS
  NAMES X11/extensions/Xrandr.h
  PATH_SUFFIXES X11/extensions
  DOC "The Xrandr include directory")

find_library(
  Xrandr_LIBRARIES
  NAMES Xrandr
  DOC "The Xrandr library")

if(Xrandr_INCLUDE_DIRS AND Xrandr_LIBRARIES)
  set(Xrandr_FOUND TRUE)
endif(Xrandr_INCLUDE_DIRS AND Xrandr_LIBRARIES)

if(Xrandr_FOUND)
  if(NOT Xrandr_FIND_QUIETLY)
    message(STATUS "Found Xrandr: ${Xrandr_LIBRARIES}")
  endif(NOT Xrandr_FIND_QUIETLY)
else(Xrandr_FOUND)
  if(Xrandr_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find Xrandr")
  endif(Xrandr_FIND_REQUIRED)
endif(Xrandr_FOUND)
