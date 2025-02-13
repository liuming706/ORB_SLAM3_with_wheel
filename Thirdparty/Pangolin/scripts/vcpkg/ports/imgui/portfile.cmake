vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_minimum_required(VERSION 2022-11-10)

if("docking-experimental" IN_LIST FEATURES)
  vcpkg_from_github(
    OUT_SOURCE_PATH
    SOURCE_PATH
    REPO
    ocornut/imgui
    REF
    595a428baa806c35622933e41a3bfb5bda68fe06
    SHA512
    c97aff2644581d68c444d07a23a5cb0a034aba4b58c787f6551b4302226393126a090ab9c9932edae2f4655a5e76008a5d249154c45d36a772490884b71c6581
    HEAD_REF
    docking)
else()
  vcpkg_from_github(
    OUT_SOURCE_PATH
    SOURCE_PATH
    REPO
    ocornut/imgui
    REF
    v${VERSION}
    SHA512
    1a87a4865cd6d3a1de4b64e59e89b88093354bcb3b1759e0fd7dfb226bca0ddc9727c44e519345a9fd098b3d4fe24a4436c38076f5659182aa70bb62f594fc03
    HEAD_REF
    master)
endif()

file(COPY "${CMAKE_CURRENT_LIST_DIR}/imgui-config.cmake.in"
     DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt"
     DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  FEATURES
  allegro5-binding
  IMGUI_BUILD_ALLEGRO5_BINDING
  dx9-binding
  IMGUI_BUILD_DX9_BINDING
  dx10-binding
  IMGUI_BUILD_DX10_BINDING
  dx11-binding
  IMGUI_BUILD_DX11_BINDING
  dx12-binding
  IMGUI_BUILD_DX12_BINDING
  glfw-binding
  IMGUI_BUILD_GLFW_BINDING
  glut-binding
  IMGUI_BUILD_GLUT_BINDING
  metal-binding
  IMGUI_BUILD_METAL_BINDING
  opengl2-binding
  IMGUI_BUILD_OPENGL2_BINDING
  opengl3-binding
  IMGUI_BUILD_OPENGL3_BINDING
  osx-binding
  IMGUI_BUILD_OSX_BINDING
  sdl2-binding
  IMGUI_BUILD_SDL2_BINDING
  sdl2-renderer-binding
  IMGUI_BUILD_SDL2_RENDERER_BINDING
  vulkan-binding
  IMGUI_BUILD_VULKAN_BINDING
  win32-binding
  IMGUI_BUILD_WIN32_BINDING
  freetype
  IMGUI_FREETYPE
  wchar32
  IMGUI_USE_WCHAR32)

if("libigl-imgui" IN_LIST FEATURES)
  vcpkg_download_distfile(
    IMGUI_FONTS_DROID_SANS_H
    URLS
    https://raw.githubusercontent.com/libigl/libigl-imgui/c3efb9b62780f55f9bba34561f79a3087e057fc0/imgui_fonts_droid_sans.h
    FILENAME
    "imgui_fonts_droid_sans.h"
    SHA512
    abe9250c9a5989e0a3f2285bbcc83696ff8e38c1f5657c358e6fe616ff792d3c6e5ff2fa23c2eeae7d7b307392e0dc798a95d14f6d10f8e9bfbd7768d36d8b31
  )

  file(INSTALL "${IMGUI_FONTS_DROID_SANS_H}"
       DESTINATION "${CURRENT_PACKAGES_DIR}/include")
endif()

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS ${FEATURE_OPTIONS}
                      OPTIONS_DEBUG -DIMGUI_SKIP_HEADERS=ON)

vcpkg_cmake_install()

if("freetype" IN_LIST FEATURES)
  vcpkg_replace_string(
    "${CURRENT_PACKAGES_DIR}/include/imconfig.h"
    "//#define IMGUI_ENABLE_FREETYPE" "#define IMGUI_ENABLE_FREETYPE")
endif()
if("wchar32" IN_LIST FEATURES)
  vcpkg_replace_string(
    "${CURRENT_PACKAGES_DIR}/include/imconfig.h" "//#define IMGUI_USE_WCHAR32"
    "#define IMGUI_USE_WCHAR32")
endif()

vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
