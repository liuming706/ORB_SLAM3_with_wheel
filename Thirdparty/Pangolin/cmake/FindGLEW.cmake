#
# Try to find GLEW library and include path. Once done this will define
#
# GLEW_FOUND GLEW_INCLUDE_DIR GLEW_LIBRARY
#

if(WIN32)
  find_path(GLEW_INCLUDE_DIR GL/glew.h $ENV{PROGRAMFILES}/GLEW/include
            ${PROJECT_SOURCE_DIR}/src/nvgl/glew/include
            DOC "The directory where GL/glew.h resides")
  find_library(
    GLEW_LIBRARY
    NAMES glew GLEW glew32 glew32s
    PATHS $ENV{PROGRAMFILES}/GLEW/lib ${PROJECT_SOURCE_DIR}/src/nvgl/glew/bin
          ${PROJECT_SOURCE_DIR}/src/nvgl/glew/lib
    DOC "The GLEW library")
else(WIN32)
  find_path(GLEW_INCLUDE_DIR GL/glew.h /usr/include /usr/local/include
            /sw/include /opt/local/include
            DOC "The directory where GL/glew.h resides")
  find_library(
    GLEW_LIBRARY
    NAMES GLEW glew
    PATHS /usr/lib64 /usr/lib /usr/local/lib64 /usr/local/lib /sw/lib
          /opt/local/lib
    DOC "The GLEW library")
endif(WIN32)

if(GLEW_INCLUDE_DIR AND GLEW_LIBRARY)
  set(GLEW_FOUND TRUE)
endif(GLEW_INCLUDE_DIR AND GLEW_LIBRARY)

if(GLEW_FOUND)
  if(NOT GLEW_FIND_QUIETLY)
    message(STATUS "Found GLEW: ${GLEW_LIBRARY}")
  endif(NOT GLEW_FIND_QUIETLY)
else(GLEW_FOUND)
  if(GLEW_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find GLEW")
  endif(GLEW_FIND_REQUIRED)
endif(GLEW_FOUND)
