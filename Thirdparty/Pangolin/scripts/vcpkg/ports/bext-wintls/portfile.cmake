vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  laudrup/boost-wintls
  REF
  v0.9.5
  SHA512
  5b6a88d64225c0f065d18f65319d44b90eb594431c53d9fbff72edfe2fc909613a966062b5636db7a3d0e36a389a0948dada0fbfa61b21b7b52b1af952d93071
  HEAD_REF
  master)

file(COPY "${SOURCE_PATH}/include/boost/"
     DESTINATION "${CURRENT_PACKAGES_DIR}/include/boost/")

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}/"
  RENAME copyright)
