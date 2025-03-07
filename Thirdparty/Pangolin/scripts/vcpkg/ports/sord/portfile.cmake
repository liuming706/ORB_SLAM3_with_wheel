vcpkg_from_gitlab(
  GITLAB_URL
  https://gitlab.com
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  drobilla/sord
  REF
  v0.16.4
  SHA512
  cad8f8fd07afb5075938fce247d95f9d666f61f4d913ff0c3fde335384177de066a5c0f2620c76e098178aeded0412b3e76ef63a1ae65aba7eb99e3e8ce15896
  HEAD_REF
  master)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt"
     DESTINATION "${SOURCE_PATH}")

vcpkg_configure_cmake(SOURCE_PATH "${SOURCE_PATH}" PREFER_NINJA OPTIONS_DEBUG
                      -DDISABLE_INSTALL_HEADERS=1)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets()
file(
  INSTALL "${SOURCE_PATH}/COPYING"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
