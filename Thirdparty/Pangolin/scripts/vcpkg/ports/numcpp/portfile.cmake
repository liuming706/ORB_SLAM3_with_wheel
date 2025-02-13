# header-only library
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  dpilger26/NumCpp
  REF
  Version_2.6.0
  SHA512
  4D057941F4CB541CFAA56E4188C865DFC1804CA1B2203422B9EB7D7E8EE43CCB15DC5109DA5C932234E6055B6A5554D877347FA7CAEC5EA619A2975A56D2B16C
  HEAD_REF
  master)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME NumCpp CONFIG_PATH share/NumCpp/cmake)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
