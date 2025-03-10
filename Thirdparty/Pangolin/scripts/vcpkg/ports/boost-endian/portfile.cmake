# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/endian
  REF
  boost-1.81.0
  SHA512
  85fd0ce8b8a85e73dae0db0610d1fe6a61cffa4a2d9f26e9a73a58df92594af8f24eb9a86441161001b372f30a37b86d25a173e839c0440713ae2d02a96f5d74
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
