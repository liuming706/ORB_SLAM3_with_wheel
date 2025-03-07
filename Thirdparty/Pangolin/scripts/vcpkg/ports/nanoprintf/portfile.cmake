# header-only library
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  charlesnicholson/nanoprintf
  REF
  b210b50a2b8608e2f0226b47a8f82c3476177a4f
  SHA512
  8340bf3785a8609568188e28e3fb905007d6da052f860df02fe0b8b2fdef3ca1ac87b91f7ac203fbd7235bcd50c8a63f33b2fca2854cad1351899c59cd8d7646
  HEAD_REF
  master)

file(COPY ${SOURCE_PATH}/nanoprintf.h
     DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
