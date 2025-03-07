vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  jpbarrette/curlpp
  REF
  8810334c830faa3b38bcd94f5b1ab695a4f05eb9
  SHA512
  47eb0738d7cd2d4262c455f9472a21535343bcf08bda6de19771dab9204e068272b41782c87057d50e3781683a29e79d6387577be68d175a7fa890367f15d0d2
  HEAD_REF
  master
  PATCHES
  fix-cmake.patch
  fix-findzliberror.patch)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT} PACKAGE_NAME
                         unofficial-${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin"
       "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

if(VCPKG_TARGET_IS_WINDOWS AND NOT (VCPKG_LIBRARY_LINKAGE STREQUAL static))
  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/bin/curlpp-config"
                       "${CURRENT_PACKAGES_DIR}" "`dirname $0`/..")
  if(NOT VCPKG_BUILD_TYPE)
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/bin/curlpp-config"
                         "${CURRENT_PACKAGES_DIR}" "`dirname $0`/../..")
  endif()
endif()

vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/unofficial-${PORT}")
file(
  INSTALL "${SOURCE_PATH}/doc/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
