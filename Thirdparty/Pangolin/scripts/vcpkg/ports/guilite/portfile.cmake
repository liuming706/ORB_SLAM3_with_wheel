vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  idea4good/GuiLite
  REF
  61d1bd94cbc35da74c0f3c40422a7d783c04d40b
  SHA512
  b428e9bfc62fabb4d23d4c39b78d521aa13eb52e571a5aaab7609a03bb88e6f2184587885cd4df950eb5f48dece2b8fbff2264f158251ed06c6a6415b9b59f1a
  HEAD_REF
  master)

file(INSTALL "${SOURCE_PATH}/GuiLite.h"
     DESTINATION "${CURRENT_PACKAGES_DIR}/include")
configure_file("${SOURCE_PATH}/LICENSE"
               "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" COPYONLY)
