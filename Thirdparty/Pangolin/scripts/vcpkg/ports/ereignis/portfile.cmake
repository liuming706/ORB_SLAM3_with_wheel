vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  Soundux/ereignis
  REF
  v1.1
  SHA512
  506a54e8d109028cd9e85597fbd6bf77694d55e78727d2889aa15846eb4ef00390153b719c6eb3d7f8d424eb7607b66f18adc24a2d907887e32c30ca0dca7034
  HEAD_REF
  master)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
