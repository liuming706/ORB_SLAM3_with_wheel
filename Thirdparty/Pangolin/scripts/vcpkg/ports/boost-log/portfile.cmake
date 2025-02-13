# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  boostorg/log
  REF
  boost-1.81.0
  SHA512
  916d4e820a1d12ff171960da9f37b273c16bd3b59d3c118b335af17b49795aec250761ae38fa3c0360468b16190161b5782020c6517805631af82861c83a6993
  HEAD_REF
  master)

file(READ "${SOURCE_PATH}/build/Jamfile.v2" _contents)
string(REPLACE "import ../../config/checks/config"
               "import ../config/checks/config" _contents "${_contents}")
string(REPLACE " <conditional>@select-arch-specific-sources"
               "#<conditional>@select-arch-specific-sources" _contents
               "${_contents}")
file(WRITE "${SOURCE_PATH}/build/Jamfile.v2" "${_contents}")
vcpkg_replace_string(
  "${SOURCE_PATH}/build/log-arch-config.jam"
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
