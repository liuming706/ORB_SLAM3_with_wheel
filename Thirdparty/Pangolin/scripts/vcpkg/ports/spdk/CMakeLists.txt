cmake_minimum_required(VERSION 3.9)
project(spdk C)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}")
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_SOURCE_DIR}")

find_package(Numa REQUIRED)
find_package(uuid REQUIRED)
find_package(ibverbs REQUIRED)
find_package(RDMA REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(
  Python
  COMPONENTS Interpreter
  REQUIRED)

find_program(MAKE make)

if(SOURCE_PATH)
  set(CMAKE_SOURCE_DIR ${SOURCE_PATH})
endif()

set(SPDK_CONFIG
    --disable-tests
    --with-rdma
    --without-isal
    --with-dpdk=${CMAKE_SOURCE_DIR}/../../../spdk-dpdk/src/spdk-18.11-411c51fb97/build
)
# No option to define path for isa-l
# (--with-isal=${CMAKE_SOURCE_DIR}/../../../spdk-isal/src/spdk-d34ebb51cd)
if(CMAKE_BUILD_TYPE STREQUAL Debug)
  list(APPEND ${SPDK_CONFIG} --enable-debug)
endif()

set(DPDK_CONFIG "-fPIC")
if(CMAKE_BUILD_TYPE STREQUAL Debug)
  string(APPEND ${DPDK_CONFIG} "-O0 -g")
endif()

add_custom_target(
  spdk-configure
  COMMAND ./configure ${SPDK_CONFIG}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/
  VERBATIM)

add_custom_target(
  spdk ALL
  COMMAND ${MAKE} -j DPDK_CFLAGS=${DPDK_CONFIG}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/)

add_dependencies(spdk spdk-configure)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/build/lib
        DESTINATION ${CMAKE_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/)
