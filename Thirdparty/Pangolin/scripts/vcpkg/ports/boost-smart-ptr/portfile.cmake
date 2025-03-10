# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/smart_ptr
  REF
  boost-1.81.0
  SHA512
  dd4c9a9992063bdc7f68a27de7840ce4e0cbfd6c878705d7e1babc2f79e0e6b6841be72c3202b927ad14b5764c83253e1e8ff6e9d8007d3febf2dfafdbfa9c56
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
