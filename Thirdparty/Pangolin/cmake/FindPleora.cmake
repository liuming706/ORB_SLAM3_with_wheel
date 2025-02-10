# * Try to find Pleora SDK
#
# Pleora_FOUND - system has pleora eUSB SDK Pleora_INCLUDE_DIRS - the pleora
# eUSB SDK include directories Pleora_LIBRARIES - link these to use pleora eUSB
# SDK Pleora_BASE_DIR - set env varivales to this to use pleora eUSB SDK

set(INCLUDE_SEARCH_PATHS
    "/opt/pleora/ebus_sdk/Ubuntu-12.04-x86_64/include"
    "/opt/pleora/ebus_sdk/Ubuntu-14.04-x86_64/include"
    "$ENV{ProgramFiles}/Pleora Technologies Inc/eBUS SDK/Includes")

set(LIBRARIES_SEARCH_PATHS
    "/opt/pleora/ebus_sdk/Ubuntu-12.04-x86_64/lib"
    "/opt/pleora/ebus_sdk/Ubuntu-14.04-x86_64/lib"
    "$ENV{ProgramFiles}/Pleora Technologies Inc/eBUS SDK/Libraries")

set(GENAPI_SEARCH_PATHS
    "/opt/pleora/ebus_sdk/Ubuntu-12.04-x86_64/lib/genicam/bin/Linux64_x64"
    "/opt/pleora/ebus_sdk/Ubuntu-12.04-x86_64/lib/genicam/bin/Linux32_ARM"
    "/opt/pleora/ebus_sdk/Ubuntu-14.04-x86_64/lib/genicam/bin/Linux64_x64"
    "/opt/pleora/ebus_sdk/Ubuntu-14.04-x86_64/lib/genicam/bin/Linux32_ARM"
    "$ENV{ProgramW6432}/GenICam_v2_4/library/CPP/lib/Win64_x64")

if(${CMAKE_CL_64})
  set(LIB_NAME_SUFFIX "64")
else()
  set(LIB_NAME_SUFFIX "")
endif()

# Find header files
find_path(
  PVBASE_INCLUDE_DIR PvBase.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVDEVICE_INCLUDE_DIR PvDevice.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVBUFFER_INCLUDE_DIR PvBuffer.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVGENICAM_INCLUDE_DIR PvGenICamLib.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVSTREAM_INCLUDE_DIR PvStream.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVTRANSMITTER_INCLUDE_DIR PvTransmitterLib.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVVIRTUALDEVICE_INCLUDE_DIR PvVirtualDeviceLib.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})
find_path(
  PVSAMPLEUTILS_INCLUDE_DIR PvSampleUtils.h
  HINTS ${PC_PLEORA_DIR}/include
  PATHS ${INCLUDE_SEARCH_PATHS})

# Find Library files
find_library(
  PVBASE_LIBRARY
  NAMES "PvBase${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})
find_library(
  PVDEVICE_LIBRARY
  NAMES "PvDevice${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})

find_library(
  PVBUFFER_LIBRARY
  NAMES "PvBuffer${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})
find_library(
  PVGENICAM_LIBRARY
  NAMES "PvGenICam${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})
find_library(
  PVSTREAM_LIBRARY
  NAMES "PvStream${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})
find_library(
  PVTRANSMITTER_LIBRARY
  NAMES "PvTransmitter${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})
find_library(
  PVVIRTUALDEVICE_LIBRARY
  NAMES "PvVirtualDevice${LIB_NAME_SUFFIX}"
  HINTS ${PC_PLEORA_DIR}/lib PATH ${LIBRARIES_SEARCH_PATHS})
find_library(
  GENAPI_LIBRARY
  NAMES GenApi_gcc40_v2_4 GenApi_gcc43_v2_4 GenApi_MD_VC80_v2_4
  HINTS ${PC_GENAPI_LIBRARY_DIR} PATH ${GENAPI_SEARCH_PATHS})

if(PVBASE_INCLUDE_DIR
   AND PVDEVICE_INCLUDE_DIR
   AND PVBUFFER_INCLUDE_DIR
   AND PVGENICAM_INCLUDE_DIR
   AND PVSTREAM_INCLUDE_DIR
   AND PVTRANSMITTER_INCLUDE_DIR
   AND PVVIRTUALDEVICE_INCLUDE_DIR
   AND PVSAMPLEUTILS_INCLUDE_DIR
   AND PVBASE_LIBRARY
   AND PVDEVICE_LIBRARY
   AND PVBUFFER_LIBRARY
   AND PVGENICAM_LIBRARY
   AND PVSTREAM_LIBRARY
   AND PVTRANSMITTER_LIBRARY
   AND PVVIRTUALDEVICE_LIBRARY
   AND GENAPI_LIBRARY)
  set(Pleora_FOUND TRUE)
  string(REGEX REPLACE "include$" "" Pleora_BASE_DIR ${PVBASE_INCLUDE_DIR})
  set(Pleora_LIBRARIES
      ${PVBASE_LIBRARY}
      ${PVDEVICE_LIBRARY}
      ${PVBUFFER_LIBRARY}
      ${PVGENICAM_LIBRARY}
      ${PVSTREAM_LIBRARY}
      ${PVTRANSMITTER_LIBRARY}
      ${PVVIRTUALDEVICE_LIBRARY}
      ${GENAPI_LIBRARY})
  set(Pleora_INCLUDE_DIRS
      ${PVBASE_INCLUDE_DIR}
      ${PVDEVICE_INCLUDE_DIR}
      ${PVBUFFER_INCLUDE_DIR}
      ${PVGENICAM_INCLUDE_DIR}
      ${PVSTREAM_INCLUDE_DIR}
      ${PVTRANSMITTER_INCLUDE_DIR}
      ${PVVIRTUALDEVICE_INCLUDE_DIR}
      ${PVSAMPLEUTILS_INCLUDE_DIR})
endif()

if(Pleora_FOUND)
  if(NOT Pleora_FIND_QUIETLY)
    message(STATUS "Found Pleora: ${Pleora_LIBRARIES}")
  endif(NOT Pleora_FIND_QUIETLY)
else(Pleora_FOUND)
  if(Pleora_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find Pleora")
  endif(Pleora_FIND_REQUIRED)
endif(Pleora_FOUND)
