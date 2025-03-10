vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  VirusTotal/yara
  REF
  ba94b4f8ebb6d56786d14f6a0f7529b32d7c216f # v4.2.3
  SHA512
  34bbe80c0f108691c7dd36fe56a2f866fc90424417a14df80781670f8150662a6160fecc4b697c6ff7eca3f98d78cdcb91f38e7f2a6542814b739869662d6608
  HEAD_REF
  master)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt"
     DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS_DEBUG
                      -DDISABLE_INSTALL_HEADERS=ON -DDISABLE_INSTALL_TOOLS=ON)

vcpkg_cmake_install()

# Handle copyright
file(
  INSTALL "${SOURCE_PATH}/COPYING"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
