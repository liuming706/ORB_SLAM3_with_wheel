vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  mohabouje/WinToast
  REF
  v1.2.0
  SHA512
  d8bd44439100772929eb8a4eb4aebfd66fa54562c838eb4c081a382dc1d73c545faa6d9675e320864d9b533e4a0c4a673e44058c7f643ccd56ec90830cdfaf45
  HEAD_REF
  master)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt"
     DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS_RELEASE
                      -DINSTALL_HEADERS=ON OPTIONS_DEBUG -DINSTALL_HEADERS=OFF)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Install license
file(
  INSTALL "${SOURCE_PATH}/LICENSE.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
