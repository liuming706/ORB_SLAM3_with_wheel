vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  banditcpp/snowhouse
  REF
  3faaff8d836c726aa2001adf3d2253d3b368b06b # v5.0.0
  SHA512
  d1fdd01b376ea26a4c9312df9f952f5b543d1f9d4a8049b7302961d3403200659cb448e5c032f9f05f4f0eeed7434d94beaf108f80cd155c37fe63eaf14651c2
  HEAD_REF
  master)

file(
  COPY ${SOURCE_PATH}/include/snowhouse
  DESTINATION ${CURRENT_PACKAGES_DIR}/include/
  FILES_MATCHING
  PATTERN *.h)

file(COPY ${SOURCE_PATH}/LICENSE_1_0.txt
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/snowhouse)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/snowhouse/LICENSE_1_0.txt
     ${CURRENT_PACKAGES_DIR}/share/snowhouse/copyright)
