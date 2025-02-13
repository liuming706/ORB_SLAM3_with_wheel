# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/variant2
  REF
  boost-1.81.0
  SHA512
  6ff9254e67cdacfb129a5746b47d3ab23ef2e61fd2cbf9424c32669f6abcb5858e9d5aef01f0dfd8ac214337e32a22195998ec962d54bc21244dc0b79579deae
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
