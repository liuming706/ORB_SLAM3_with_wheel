# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/flyweight
  REF
  boost-1.81.0
  SHA512
  a918d7ec365b22c62297dd62069cb33e8337750ddfc0ff48757ccef8954ac2a055bbf65ea93eddf366c44a6b7c9da4e32268b420244eeff35158da9f8ec34d15
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
