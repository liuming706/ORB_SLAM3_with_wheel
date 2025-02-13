vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  dorian3d/DBoW2
  REF
  4d08e9fc751fac9063874d85a43c1ccdcda8b401
  SHA512
  0a4ad8506c731395cb23d96d0e8afe4131576af88468723b9496cdbc95a031089ecdeb61dbb7205cb3a7599acb60a39887fa9852e7d7a690b8152a1bd26d9bd0
  HEAD_REF
  master)

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA OPTIONS
                      -DBUILD_Demo=OFF)

vcpkg_install_cmake()

# Move CMake files to the right place
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/DBoW2)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/DBoW2/DBoW2Config.cmake)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/${PORT}/LICENSE.txt
     ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright)
