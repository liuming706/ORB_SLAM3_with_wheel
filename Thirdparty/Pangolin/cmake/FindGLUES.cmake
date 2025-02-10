# Try to find the GLUES lib and include files
#
# GLUES_INCLUDE_DIR GLUES_LIBRARIES GLUES_FOUND

find_path(
  GLUES_INCLUDE_DIR
  glues/glues.h
  /usr/include
  /usr/local/include
  /opt/include
  /opt/local/include
  ${CMAKE_INSTALL_PREFIX}/include)

find_library(
  GLUES_LIBRARY
  glues
  /usr/lib64
  /usr/lib
  /usr/local/lib
  /opt/local/lib
  /opt/local/lib64
  ${CMAKE_INSTALL_PREFIX}/lib)

if(GLUES_INCLUDE_DIR AND GLUES_LIBRARY)
  set(GLUES_FOUND TRUE)
  set(GLUES_LIBRARIES ${GLUES_LIBRARY})
endif(GLUES_INCLUDE_DIR AND GLUES_LIBRARY)

if(GLUES_FOUND)
  if(NOT GLUES_FIND_QUIETLY)
    message(STATUS "Found GLUES: ${GLUES_LIBRARY}")
  endif(NOT GLUES_FIND_QUIETLY)
else(GLUES_FOUND)
  if(GLUES_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find GLUES")
  endif(GLUES_FIND_REQUIRED)
endif(GLUES_FOUND)
