# Try to find the DepthSense SDK For SoftKinetic Cameras
#
# DepthSense_INCLUDE_DIRS DepthSense_LIBRARIES DepthSense_FOUND

find_path(
  DepthSense_INCLUDE_DIR DepthSense.hxx
  PATHS "${PROGRAM_FILES}/SoftKinetic/DepthSenseSDK/include"
        "${PROGRAM_FILES}/Meta/DepthSenseSDK/include"
        /usr/include
        /usr/local/include
        /opt/local/include
        /opt/softkinetic/DepthSenseSDK/include)

find_library(
  DepthSense_LIBRARY DepthSense
  PATHS "${PROGRAM_FILES}/SoftKinetic/DepthSenseSDK/lib"
        "${PROGRAM_FILES}/Meta/DepthSenseSDK/lib"
        /usr/lib64
        /usr/lib
        /usr/local/lib
        /opt/local/lib
        /opt/softkinetic/DepthSenseSDK/lib)

if(DepthSense_INCLUDE_DIR AND DepthSense_LIBRARY)
  set(DepthSense_FOUND TRUE)
  set(DepthSense_LIBRARIES ${DepthSense_LIBRARY})
  set(DepthSense_INCLUDE_DIRS ${DepthSense_INCLUDE_DIR})
endif()

if(DepthSense_FOUND)
  if(NOT DepthSense_FIND_QUIETLY)
    message(STATUS "Found DepthSense: ${DepthSense_LIBRARY}")
  endif()
else()
  if(DepthSense_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find DepthSense")
  endif()
endif()
