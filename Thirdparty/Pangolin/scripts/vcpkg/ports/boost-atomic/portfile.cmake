# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/atomic
  REF
  boost-1.81.0
  SHA512
  2a581e1cea33016f84d47d51a51d8bff91a7e2ba57f5acde4ffa5b95fcc6b73da4e276ca0616c43282ee11a21c9bdb715c10b09204a59f885d00965de6092efe
  HEAD_REF
  master)

vcpkg_replace_string(
  "${SOURCE_PATH}/build/Jamfile.v2"
  "project.load [ path.join [ path.make $(here:D) ] ../../config/checks/architecture ]"
  "project.load [ path.join [ path.make $(here:D) ] ../config/checks/architecture ]"
)
file(COPY "${CURRENT_INSTALLED_DIR}/share/boost-config/checks"
     DESTINATION "${SOURCE_PATH}/config")
include(
  ${CURRENT_HOST_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(
  ${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake
)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
