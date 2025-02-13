# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/type_erasure
  REF
  boost-1.81.0
  SHA512
  64508fe58bfd05cf3ec9e6e7791dee6d4f7150da2e6ca4ba1b714f9afebae7ba2ac5562684a7c59c453f2a3e9fd65b7ed0fd0f15626235f543f3d0db8d035926
  HEAD_REF
  master)

include(
  ${CURRENT_HOST_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
