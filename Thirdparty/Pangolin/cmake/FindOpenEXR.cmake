# Try to find the OpenEXR v2 lib and include files
#
# OpenEXR_INCLUDE_DIR OpenEXR_LIBRARIES OpenEXR_FOUND

find_path(OpenEXR_INCLUDE_DIR ImfHeader.h /usr/include /usr/local/include
          PATH_SUFFIXES OpenEXR)

find_library(OpenEXR_LIBRARY IlmImf /usr/lib64 /usr/lib /usr/local/lib)

if(OpenEXR_INCLUDE_DIR AND OpenEXR_LIBRARY)
  set(OpenEXR_FOUND TRUE)
  set(OpenEXR_LIBRARIES ${OpenEXR_LIBRARY})
endif()

if(OpenEXR_FOUND)
  if(NOT OpenEXR_FIND_QUIETLY)
    message(STATUS "Found OpenEXR: ${OpenEXR_LIBRARY}")
  endif(NOT OpenEXR_FIND_QUIETLY)
else(OpenEXR_FOUND)
  if(OpenEXR_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find libOpenEXR")
  endif(OpenEXR_FIND_REQUIRED)
endif(OpenEXR_FOUND)
