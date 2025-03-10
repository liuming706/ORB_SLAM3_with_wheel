# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/serialization
  REF
  boost-1.81.0
  SHA512
  38b4c3dd6f96d3ea4162298c378320d9dd253341ad4d19a6f3be0ec555e60d8d5977ab10905bf8eccd7c0555f097e95bf8254e81f0b5c7f6660d5720b712b8e8
  HEAD_REF
  master)

include(
  ${CURRENT_HOST_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
