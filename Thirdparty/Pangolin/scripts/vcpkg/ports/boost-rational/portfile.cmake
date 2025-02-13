# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/rational
  REF
  boost-1.81.0
  SHA512
  6d3c8bd8b45448f23bfb5da85a2a54a303384b47569c4deb34230e810c3f8eecea96b1a8c33f22603b148318d25b1b741e5dd5513bea674a89990c7cf7fdfd94
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
