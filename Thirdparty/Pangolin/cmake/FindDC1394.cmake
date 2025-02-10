# Try to find the dc1394 v2 lib and include files
#
# DC1394_INCLUDE_DIR DC1394_LIBRARIES DC1394_FOUND

find_path(DC1394_INCLUDE_DIR dc1394/control.h /usr/include /usr/local/include)

find_library(DC1394_LIBRARY dc1394 /usr/lib64 /usr/lib /usr/local/lib)

if(DC1394_INCLUDE_DIR AND DC1394_LIBRARY)
  set(DC1394_FOUND TRUE)
  set(DC1394_LIBRARIES ${DC1394_LIBRARY})
endif(DC1394_INCLUDE_DIR AND DC1394_LIBRARY)

if(DC1394_FOUND)
  if(NOT DC1394_FIND_QUIETLY)
    message(STATUS "Found DC1394: ${DC1394_LIBRARY}")
  endif(NOT DC1394_FIND_QUIETLY)
else(DC1394_FOUND)
  if(DC1394_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find libdc1394")
  endif(DC1394_FIND_REQUIRED)
endif(DC1394_FOUND)
