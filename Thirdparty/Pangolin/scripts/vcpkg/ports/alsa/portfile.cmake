if(NOT VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
  message(FATAL_ERROR "Package only supports Linux platform.")
endif()

message(
  "alsa currently requires the following libraries from the system package manager:
    autoconf libtool
These can be installed on Ubuntu systems via sudo apt install autoconf libtool")

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  alsa-project/alsa-lib
  REF
  v1.2.6.1
  SHA512
  d1de9112ec0d600db6e5a20b558811a7a9f34d00a9b1dfb5332669b73732c1c1b8ddda57368edc199e255eba8bcb8a6767b4d9325c9860ade02d84dcaac6eb47
  HEAD_REF
  master
  PATCHES
  "fix-plugin-dir.patch")

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
  set(BUILD_OPTS --enable-shared=yes --enable-static=no)
else()
  set(BUILD_OPTS --enable-shared=no --enable-static=yes)
endif()

set(ARCH64 "x64;arm64")
set(ARCH32 "x86;arm")
if((VCPKG_TARGET_ARCHITECTURE IN_LIST ARCH64) AND (EXISTS "/usr/lib64/alsa-lib"
                                                  ))
  set(ALSA_PLUGIN_DIR "/usr/lib64/alsa-lib")
elseif((VCPKG_TARGET_ARCHITECTURE IN_LIST ARCH32) AND (EXISTS
                                                       "/usr/lib32/alsa-lib"))
  set(ALSA_PLUGIN_DIR "/usr/lib32/alsa-lib")
else()
  set(ALSA_PLUGIN_DIR "/usr/lib/alsa-lib")
endif()
set(ALSA_CONFIG_DIR "/usr/share/alsa")

vcpkg_configure_make(
  SOURCE_PATH
  "${SOURCE_PATH}"
  AUTOCONFIG
  OPTIONS
  ${BUILD_OPTS}
  --disable-python
  "--with-configdir=${ALSA_CONFIG_DIR}"
  "--with-plugindir=${ALSA_PLUGIN_DIR}")

vcpkg_install_make()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/tools/alsa/debug")

configure_file("${SOURCE_PATH}/COPYING"
               "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" COPYONLY)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
