vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  fpagliughi/sockpp
  REF
  999ad87296e34d5a8e4edf15d985315d0d84eda7
  SHA512
  159b9288f45d5f5144a002f35caf520e55a66c2d45cdb1fe325021f100db0770601e973b86ec5b032e5bea1542203b30eba3e6be20e03c78f0504b62da1900b3
  HEAD_REF
  master)

vcpkg_replace_string("${SOURCE_PATH}/CMakeLists.txt" "\${SOCKPP}-static"
                     "\${SOCKPP}")

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  -DSOCKPP_BUILD_SHARED=OFF
  -DSOCKPP_BUILD_STATIC=ON
  -DSOCKPP_BUILD_DOCUMENTATION=OFF
  -DSOCKPP_BUILD_EXAMPLES=OFF
  -DSOCKPP_BUILD_TESTS=OFF)

vcpkg_cmake_install()

file(INSTALL "${CURRENT_PORT_DIR}/sockppConfig.cmake"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(COPY "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
