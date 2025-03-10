# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/iterator
  REF
  boost-1.81.0
  SHA512
  f96ad21b425922efa5d2c793f72a6b6515a3251816b0bf4554c9f95c59925fdb97f1505c8f7f9bf8b5d2bf05b13ebf27e89d674c7379eac084b37c5e6ff79bf2
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
