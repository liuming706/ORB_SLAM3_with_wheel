# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/callable_traits
  REF
  boost-1.81.0
  SHA512
  51fd9e84ed411d9a567ca117339f50de3dea13f8cf8e4d39a0ee26ad6fcf10ba922b9d233ba0f3eb0a80a1943fa8316303ae363cea57688d232cc67a07dc17a5
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
