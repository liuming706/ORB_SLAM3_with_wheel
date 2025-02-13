# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/compute
  REF
  boost-1.81.0
  SHA512
  e4271120d0f7dad73bdafd391b4fbc69118486a9ead46bb232c20302323bd62513abc0c5d5696b45791472e78a95b1ec6d8f013fd69f9f65391df5a82f2aff54
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
