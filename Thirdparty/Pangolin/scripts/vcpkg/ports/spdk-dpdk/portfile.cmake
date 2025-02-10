if(NOT VCPKG_CMAKE_SYSTEM_NAME OR NOT VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
  message(FATAL_ERROR "Intel dpdk currently only supports Linux/BSD platforms")
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  spdk/dpdk
  REF
  spdk-18.11
  SHA512
  9c069bb0e445f8287ee056452fa32263746f78e27377e8fd75809b9ebf7f25c2395ee13ae4804d8c464e5bc7db7335692759ab3202748dd0c82243aad35e5e7c
  HEAD_REF
  master)

find_path(
  NUMA_INCLUDE_DIR NAME numa.h
  PATHS ENV NUMA_ROOT
  HINTS $ENV{HOME}/local/include /opt/local/include /usr/local/include
        /usr/include)
if(NOT NUMA_INCLUDE_DIR)
  message(
    FATAL_ERROR
      "Numa library not found.\nTry: 'sudo yum install numactl numactl-devel' (or sudo apt-get install libnuma1 libnuma-dev)"
  )
endif()

vcpkg_configure_cmake(SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR} PREFER_NINJA
                      OPTIONS -DSOURCE_PATH=${SOURCE_PATH})

vcpkg_install_cmake()

# Headers are symbolic links here, gather all, resolve and copy real files
file(GLOB_RECURSE HEADERS FOLLOW_SYMLINKS "${SOURCE_PATH}/build/include/*")
set(REAL_FILES "")
foreach(HEADER ${HEADERS})
  get_filename_component(REAL_FILE "${HEADER}" REALPATH)
  list(APPEND REAL_FILES "${REAL_FILE}")
endforeach()

file(INSTALL ${SOURCE_PATH}/Release/lib/
     DESTINATION ${CURRENT_PACKAGES_DIR}/lib/spdk)
if(NOT VCPKG_BUILD_TYPE)
  file(INSTALL ${SOURCE_PATH}/Debug/lib/
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/spdk)
endif()
file(INSTALL ${REAL_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/spdk-dpdkConfig.cmake
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(
  INSTALL ${SOURCE_PATH}/license/README
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
