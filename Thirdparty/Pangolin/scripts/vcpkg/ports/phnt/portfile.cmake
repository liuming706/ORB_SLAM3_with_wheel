vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  processhacker/phnt
  REF
  3f19efe9fd402378c7cd12fe1c0aacd154c8cd3c
  SHA512
  88f1f5ab1f2c8b3100e47f43cee7bdcb412ef9f688e3840ddc8a78d8b75b4baf714aadc27829e0ea95d97a22031019d25f9916d09bb63cea37304e9c9c08285a
  HEAD_REF
  master)

file(GLOB HEADER_FILES ${SOURCE_PATH}/*.h)
file(INSTALL ${HEADER_FILES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

configure_file(${SOURCE_PATH}/LICENSE
               ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
