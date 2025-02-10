# * Try to find pthread
#
# pthread_FOUND - system has pthread pthread_INCLUDE_DIRS - the pthread include
# directories pthread_LIBRARIES - link these to use pthread

find_path(
  pthread_INCLUDE_DIRS
  NAMES pthread.h
  PATHS c:/dev/sysroot32/usr/include ${CMAKE_SOURCE_DIR}/../pthread/include
        /usr/include/ /usr/local/include /opt/local/include)

find_library(
  pthread_LIBRARIES
  NAMES pthreadVSE2 pthread
  PATHS c:/dev/sysroot32/usr/lib ${CMAKE_SOURCE_DIR}/../pthread/lib /usr/lib
        /usr/local/lib /opt/local/lib)

if(pthread_INCLUDE_DIRS AND pthread_LIBRARIES)
  set(pthread_FOUND TRUE)
endif(pthread_INCLUDE_DIRS AND pthread_LIBRARIES)

if(pthread_FOUND)
  if(NOT pthread_FIND_QUIETLY)
    message(STATUS "Found pthread: ${pthread_LIBRARIES}")
  endif(NOT pthread_FIND_QUIETLY)
else(pthread_FOUND)
  message(STATUS "pthread NOT found")
  if(pthread_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find pthread")
  endif(pthread_FIND_REQUIRED)
endif(pthread_FOUND)
