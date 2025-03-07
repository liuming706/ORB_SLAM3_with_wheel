vcpkg_minimum_required(VERSION 2022-10-12) # for ${VERSION}
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  libsdl-org/SDL_image
  REF
  release-${VERSION}
  SHA512
  8ecf26a13ffc00b9941bf0befb669c1fd2f2d2e9ca1dcf7210cb93eb18f49cf749af1f491f85627eed7030d1e603051720c9470bfed9b031b0219e3a47d06622
  HEAD_REF
  main
  PATCHES
  fix-pkgconfig.patch)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  FEATURES
  libjpeg-turbo
  SDL2IMAGE_JPG
  libwebp
  SDL2IMAGE_WEBP
  tiff
  SDL2IMAGE_TIF)

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  ${FEATURE_OPTIONS}
  -DSDL2IMAGE_BACKEND_IMAGEIO=OFF
  -DSDL2IMAGE_BACKEND_STB=OFF
  -DSDL2IMAGE_DEPS_SHARED=OFF
  -DSDL2IMAGE_SAMPLES=OFF
  -DSDL2IMAGE_VENDORED=OFF)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

if(EXISTS "${CURRENT_PACKAGES_DIR}/cmake")
  vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_image CONFIG_PATH cmake)
elseif(EXISTS "${CURRENT_PACKAGES_DIR}/SDL2_image.framework/Resources")
  vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_image CONFIG_PATH
                           SDL2_image.framework/Resources)
else()
  vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_image CONFIG_PATH
                           lib/cmake/SDL2_image)
endif()

vcpkg_fixup_pkgconfig()

file(
  REMOVE_RECURSE
  "${CURRENT_PACKAGES_DIR}/debug/share"
  "${CURRENT_PACKAGES_DIR}/debug/include"
  "${CURRENT_PACKAGES_DIR}/SDL2_image.framework"
  "${CURRENT_PACKAGES_DIR}/debug/SDL2_image.framework")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
