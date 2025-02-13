# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/any
  REF
  boost-1.81.0
  SHA512
  9ab99e2cf74f895a41b1efe637ba68f1afac2190a45aab67a9de10d919875e95b90851c2ddb3458b5fdab73da1adee3a58d5fd630080c3ec2c7639daabede42e
  HEAD_REF
  master)

include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
