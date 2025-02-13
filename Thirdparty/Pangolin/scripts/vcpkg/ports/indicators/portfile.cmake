# header-only library

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  p-ranav/indicators
  REF
  v2.2
  SHA512
  7CED2D3C320D51C7E0569104744730C8E2F952350BCAE214A9781EB43EF4002C8314937DB78461351741FC4C3AEE7A1364582B1274991E95EB30006A5F2A7EF9
  HEAD_REF
  master)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DINDICATORS_BUILD_TESTS=OFF
  -DINDICATORS_SAMPLES=OFF -DINDICATORS_DEMO=OFF)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/indicators)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug"
     "${CURRENT_PACKAGES_DIR}/lib")

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
file(INSTALL "${SOURCE_PATH}/LICENSE.termcolor"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
