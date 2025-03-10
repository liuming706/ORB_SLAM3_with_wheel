vcpkg_minimum_required(VERSION 2022-10-12)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  OpenImageIO/oiio
  REF
  v${VERSION}
  SHA512
  c7a4283b78197c262d8da31460ce8b07b44546f822142e32e6c1ea22376e1c4b9cfe9c39cc0994987c6c4f653c1f2764057944da97a3a090bf1bcb74a2a0b2c2
  HEAD_REF
  master
  PATCHES
  fix-dependencies.patch
  fix-static-ffmpeg.patch
  fix-openexr-dll.patch
  imath-version-guard.patch
  fix-openimageio_include_dir.patch)

file(REMOVE_RECURSE "${SOURCE_PATH}/ext")

file(
  REMOVE
  "${SOURCE_PATH}/src/cmake/modules/FindFFmpeg.cmake"
  "${SOURCE_PATH}/src/cmake/modules/FindLibheif.cmake"
  "${SOURCE_PATH}/src/cmake/modules/FindLibRaw.cmake"
  "${SOURCE_PATH}/src/cmake/modules/FindLibsquish.cmake"
  "${SOURCE_PATH}/src/cmake/modules/FindOpenCV.cmake"
  "${SOURCE_PATH}/src/cmake/modules/FindOpenJPEG.cmake"
  "${SOURCE_PATH}/src/cmake/modules/FindWebP.cmake")

vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  FEATURES
  libraw
  USE_LIBRAW
  opencolorio
  USE_OPENCOLORIO
  ffmpeg
  USE_FFMPEG
  freetype
  USE_FREETYPE
  gif
  USE_GIF
  opencv
  USE_OPENCV
  openjpeg
  USE_OPENJPEG
  webp
  USE_WEBP
  pybind11
  USE_PYTHON
  tools
  OIIO_BUILD_TOOLS
  tools
  USE_OPENGL
  tools
  USE_QT
  tools
  USE_QT5)

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  ${FEATURE_OPTIONS}
  -DBUILD_TESTING=OFF
  -DUSE_DCMTK=OFF
  -DUSE_NUKE=OFF
  -DUSE_QT=OFF
  -DUSE_OpenVDB=OFF
  -DUSE_PTEX=OFF
  -DUSE_TBB=OFF
  -DLINKSTATIC=OFF # LINKSTATIC breaks library lookup
  -DBUILD_MISSING_FMT=OFF
  -DBUILD_MISSING_ROBINMAP=OFF
  -DBUILD_MISSING_DEPS=OFF
  -DSTOP_ON_WARNING=OFF
  -DVERBOSE=ON
  -DBUILD_DOCS=OFF
  -DINSTALL_DOCS=OFF
  -DENABLE_INSTALL_testtex=OFF
  "-DREQUIRED_DEPS=fmt;JPEG;Libheif;Libsquish;PNG;Robinmap"
  MAYBE_UNUSED_VARIABLES
  ENABLE_INSTALL_testtex)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/OpenImageIO)

if("tools" IN_LIST FEATURES)
  vcpkg_copy_tools(
    TOOL_NAMES
    iconvert
    idiff
    igrep
    iinfo
    maketx
    oiiotool
    iv
    AUTO_CLEAN)
endif()

# Clean
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/doc"
     "${CURRENT_PACKAGES_DIR}/debug/include"
     "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_fixup_pkgconfig()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(
  INSTALL "${SOURCE_PATH}/LICENSE.md"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
file(READ "${SOURCE_PATH}/THIRD-PARTY.md" third_party)
string(
  REGEX
  REPLACE
    "^.*The remainder of this file"
    "\n-------------------------------------------------------------------------\n\nThe remainder of this file"
    third_party
    "${third_party}")
file(APPEND "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "${third_party}")
