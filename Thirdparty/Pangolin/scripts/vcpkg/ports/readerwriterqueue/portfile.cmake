# header-only library
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  cameron314/readerwriterqueue
  REF
  v1.0.6
  SHA512
  93606d8337ec6bb8aad23a40a7d5e685f8b97f6c75ca4a6b11947aaef02c2283648c5352d3c7f451006b2244ce45d0c04384ba0e1da8ac515ce7644f83f49f2c
  HEAD_REF
  master)

file(GLOB HEADER_FILES ${SOURCE_PATH}/*.h)
file(INSTALL ${HEADER_FILES}
     DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(
  INSTALL ${SOURCE_PATH}/LICENSE.md
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
