if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
  vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  libkml/libkml
  REF
  1.3.0
  SHA512
  aa48158103d3af764bf98c1fb4cf3e1356b9cc6c8e79d80b96850916f0a8ccb1dac3a46427735dd0bf20647daa047d10e722ac3da2a214d4c1559bf6d5d7c853
  HEAD_REF
  master
  PATCHES
  patch_empty_literal_on_vc.patch
  fix-mingw.patch
  fix-minizip.patch)

file(
  REMOVE
  "${SOURCE_PATH}/cmake/External_boost.cmake"
  "${SOURCE_PATH}/cmake/External_expat.cmake"
  "${SOURCE_PATH}/cmake/External_minizip.cmake"
  "${SOURCE_PATH}/cmake/External_uriparser.cmake"
  "${SOURCE_PATH}/cmake/External_zlib.cmake"
  "${SOURCE_PATH}/src/kml/base/contrib/minizip/ioapi.h")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()
if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_cmake_config_fixup(CONFIG_PATH cmake)
else()
  vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/libkml)
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
