vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  bshoshany/thread-pool
  REF
  v3.3.0
  SHA512
  980c8dfe90e04cbc622ee4ae2ce67444069311619f0dc5d7ac3b3a3ea59ead42d4c867e669e8ce9c71cdc2a4bae431402a8f5032ab29fdfc1ca507b0e7102d8f
  HEAD_REF
  master)

file(
  GLOB HEADER_FILES
  LIST_DIRECTORIES false
  "${SOURCE_PATH}/*.hpp")

file(INSTALL ${HEADER_FILES} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(
  INSTALL "${SOURCE_PATH}/LICENSE.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
