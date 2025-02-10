cmake_minimum_required(VERSION 3.9)
project(dpdk C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}")
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}")

include(ProcessorCount)
ProcessorCount(PROCS)

# ARCH can be: i686, x86_64, ppc_64, arm64 MACHINE can be: native, power8,
# armv8a EXECENV can be: linuxapp, bsdapp TOOLCHAIN can be: gcc, icc

set(ARCH x86_64)
set(MACHINE native)
set(EXECENV linuxapp)
set(TOOLCHAIN gcc)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^i.86$")
  set(ARCH "i686")
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^arm")
  set(MACHINE arm8a)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(powerpc|ppc)64")
  set(MACHINE power8)
  set(ARCH ppc_64)
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
  set(EXECENV bsdapp)
endif()

find_package(Numa REQUIRED)
find_program(MAKE make)

set(DPDK_CFLAGS "-fPIC")
if(CMAKE_BUILD_TYPE STREQUAL Debug)
  string(APPEND ${DPDK_CFLAGS} "-O0 -g")
endif()

set(DPDK_TARGET ${ARCH}-${MACHINE}-${EXECENV}-${TOOLCHAIN})
# SET(DPDK_CONFIG O=${CMAKE_BUILD_TYPE}/build T=${DPDK_TARGET})
set(DPDK_CONFIG "T=${DPDK_TARGET}")

if(SOURCE_PATH)
  set(CMAKE_SOURCE_DIR ${SOURCE_PATH})
endif()

add_custom_target(
  dpdk-configure
  COMMAND ${MAKE} config ${DPDK_CONFIG}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/
  VERBATIM)

add_custom_target(
  dpdk ALL
  COMMAND ${MAKE} EXTRA_CFLAGS=\"${DPDK_CFLAGS}\" MAKEFLAGS=\"${DPDK_CONFIG} -j
          ${PROCS}\"
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/)

add_dependencies(dpdk dpdk-configure)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/build/lib
        DESTINATION ${CMAKE_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/)
