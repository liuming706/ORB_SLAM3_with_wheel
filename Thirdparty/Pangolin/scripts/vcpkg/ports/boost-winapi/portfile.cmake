# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/winapi
  REF
  boost-1.81.0
  SHA512
  86024de36c1bd1e44dfcd875e712f819c8a30b53b9180d69d3a9c1a18b62f33b2d7d49324a29ffc03a1781bbf9235101a0c03935bae41cec7882a1ea993ceb50
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
