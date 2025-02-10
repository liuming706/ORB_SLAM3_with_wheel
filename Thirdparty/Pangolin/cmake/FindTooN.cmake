# * Try to find libTooN
#
# TooN_FOUND - system has libTooN TooN_INCLUDE_DIR - the libTooN include
# directories

find_path(
  TooN_INCLUDE_DIR
  NAMES TooN/TooN.h
  PATHS ${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/.. /usr/include
        /usr/local/include)

if(TooN_INCLUDE_DIR)
  set(TooN_FOUND TRUE)
endif()

if(TooN_FOUND)
  if(NOT TooN_FIND_QUIETLY)
    message(STATUS "Found TooN: ${TooN_INCLUDE_DIR}")
  endif()
else()
  if(TooN_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find TooN")
  endif()
endif()
