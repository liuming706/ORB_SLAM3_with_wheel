vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  mpark/variant
  REF
  v1.4.0
  SHA512
  598ef21824f9cd7586f88de5a51bfe24dde4c492e8e6b8288d2912920812c48fd01c54d9683e1620cb034563c4eac737a382620e6b4af473808a2e77017a89e3
  HEAD_REF
  master)

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/mpark_variant TARGET_PATH
                          share/mpark_variant)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/lib)

file(
  INSTALL ${SOURCE_PATH}/LICENSE.md
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/mpark-variant
  RENAME copyright)
