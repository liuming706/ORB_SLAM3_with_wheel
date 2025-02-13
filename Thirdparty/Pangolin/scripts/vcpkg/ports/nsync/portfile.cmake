if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  google/nsync
  REF
  1.24.0
  SHA512
  14dd582488072123a353c967664ed9a3f636865bb35e64d7256dcc809539129fa47c7979a4009fd45c9341cac537a4ca6b4b617ba2cae1d3995a7c251376339f
  HEAD_REF
  master
  PATCHES
  fix-install.patch
  export-targets.patch)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS
                      -DNSYNC_ENABLE_TESTS=OFF)
vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-nsync CONFIG_PATH
                         share/unofficial-nsync)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
