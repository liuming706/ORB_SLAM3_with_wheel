# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/bimap
  REF
  boost-1.81.0
  SHA512
  8b0d7a5630db6ad79c0f4e9399ac4e18eac8ba45f4a829cedae6227795a407885689bdcf3c09336069e8d4c7468546c6ddc74bba4c58bb76b62815093abba13f
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
