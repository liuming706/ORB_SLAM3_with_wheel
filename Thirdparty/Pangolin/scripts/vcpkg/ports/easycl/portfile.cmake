vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  architector1324/EasyCL
  REF
  0.3
  SHA512
  c0e9aa03c9039e9ffe4794ccc4e85654f8267924e577cf96fd8d5e141fab9e8f6dc4668ee4475d6df3ba77572e52a181493acd3dfdb0abf7bd83b7e3d4d08a29
  HEAD_REF
  master)

# Handle headers
file(
  INSTALL ${SOURCE_PATH}/include
  DESTINATION ${CURRENT_PACKAGES_DIR}
  FILES_MATCHING
  PATTERN "*.hpp")

# Handle copyright
file(
  INSTALL ${SOURCE_PATH}/COPYING
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/easycl
  RENAME copyright)
