# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/type_index
  REF
  boost-1.81.0
  SHA512
  c8affd17154ba2363546a9f40211af1fa5fa59445e7de44cb7ec655a22428825ef308aae62cdbe615e37ce165651300a9efdaecbf55beb20acc06ca899773b72
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
