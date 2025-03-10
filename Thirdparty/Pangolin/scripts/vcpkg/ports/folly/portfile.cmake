vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

# Required to run build/generate_escape_tables.py et al.
vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path("${PYTHON3_DIR}")

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  facebook/folly
  REF
  d8ed9cd2869c74b00fa6f1a7603301183f5c2249 # v2022.10.31.00
  SHA512
  55040dadb8a847f0d04c37a2dce920bb456a59decebc90920831998df9671feb33daf1f4235115adcce5eb9c469b97b9d96fa7a67a5914c434ebc1efc04f4770
  HEAD_REF
  main
  PATCHES
  reorder-glog-gflags.patch
  disable-non-underscore-posix-names.patch
  boost-1.70.patch
  fix-windows-minmax.patch
  fix-deps.patch)

file(REMOVE "${SOURCE_PATH}/CMake/FindFmt.cmake")
file(REMOVE "${SOURCE_PATH}/CMake/FindLibsodium.cmake")
file(REMOVE "${SOURCE_PATH}/CMake/FindZstd.cmake")
file(REMOVE "${SOURCE_PATH}/CMake/FindSnappy.cmake")
file(REMOVE "${SOURCE_PATH}/CMake/FindLZ4.cmake")
file(REMOVE
     "${SOURCE_PATH}/build/fbcode_builder/CMake/FindDoubleConversion.cmake")
file(REMOVE "${SOURCE_PATH}/build/fbcode_builder/CMake/FindGMock.cmake")
file(REMOVE "${SOURCE_PATH}/build/fbcode_builder/CMake/FindGflags.cmake")
file(REMOVE "${SOURCE_PATH}/build/fbcode_builder/CMake/FindGlog.cmake")
file(REMOVE "${SOURCE_PATH}/build/fbcode_builder/CMake/FindLibEvent.cmake")
file(REMOVE "${SOURCE_PATH}/build/fbcode_builder/CMake/FindSodium.cmake")
file(REMOVE "${SOURCE_PATH}/build/fbcode_builder/CMake/FindZstd.cmake")

if(VCPKG_CRT_LINKAGE STREQUAL static)
  set(MSVC_USE_STATIC_RUNTIME ON)
else()
  set(MSVC_USE_STATIC_RUNTIME OFF)
endif()

vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  FEATURES
  "zlib"
  CMAKE_REQUIRE_FIND_PACKAGE_ZLIB
  INVERTED_FEATURES
  "bzip2"
  CMAKE_DISABLE_FIND_PACKAGE_BZip2
  "lzma"
  CMAKE_DISABLE_FIND_PACKAGE_LibLZMA
  "lz4"
  CMAKE_DISABLE_FIND_PACKAGE_LZ4
  "zstd"
  CMAKE_DISABLE_FIND_PACKAGE_Zstd
  "snappy"
  CMAKE_DISABLE_FIND_PACKAGE_Snappy
  "libsodium"
  CMAKE_DISABLE_FIND_PACKAGE_unofficial-sodium)

vcpkg_cmake_configure(
  SOURCE_PATH
  ${SOURCE_PATH}
  OPTIONS
  -DMSVC_USE_STATIC_RUNTIME=${MSVC_USE_STATIC_RUNTIME}
  -DCMAKE_DISABLE_FIND_PACKAGE_LibDwarf=ON
  -DCMAKE_DISABLE_FIND_PACKAGE_Libiberty=ON
  -DCMAKE_DISABLE_FIND_PACKAGE_LibAIO=ON
  -DLIBAIO_FOUND=OFF
  -DCMAKE_INSTALL_DIR=share/folly
  ${FEATURE_OPTIONS}
  MAYBE_UNUSED_VARIABLES
  LIBAIO_FOUND)

vcpkg_cmake_install(ADD_BIN_TO_PATH)

vcpkg_copy_pdbs()

configure_file(
  "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake"
  "${CURRENT_PACKAGES_DIR}/share/${PORT}/vcpkg-cmake-wrapper.cmake" @ONLY)

vcpkg_cmake_config_fixup()

# Release folly-targets.cmake does not link to the right libraries in debug
# mode. We substitute with generator expressions so that the right libraries are
# linked for debug and release.
set(FOLLY_TARGETS_CMAKE
    "${CURRENT_PACKAGES_DIR}/share/folly/folly-targets.cmake")
file(READ ${FOLLY_TARGETS_CMAKE} _contents)
string(REPLACE "\${VCPKG_IMPORT_PREFIX}/lib/zlib.lib" "ZLIB::ZLIB" _contents
               "${_contents}")
string(REPLACE "\${VCPKG_IMPORT_PREFIX}/lib/"
               "\${VCPKG_IMPORT_PREFIX}/\$<\$<CONFIG:DEBUG>:debug/>lib/"
               _contents "${_contents}")
string(REPLACE "\${VCPKG_IMPORT_PREFIX}/debug/lib/"
               "\${VCPKG_IMPORT_PREFIX}/\$<\$<CONFIG:DEBUG>:debug/>lib/"
               _contents "${_contents}")
string(REPLACE "-vc140-mt.lib" "-vc140-mt\$<\$<CONFIG:DEBUG>:-gd>.lib"
               _contents "${_contents}")
file(WRITE ${FOLLY_TARGETS_CMAKE} "${_contents}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)

vcpkg_fixup_pkgconfig()
