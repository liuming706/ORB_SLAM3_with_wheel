vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  alecthomas/entityx
  REF
  1.3.0
  SHA512
  724a3f421f802e60a1106ff8a69435c9a9da14e35c3e88565bbc17bff3a17f2d9771818aac83320cc4f14de0ec770a66f1eb7cbf4318f43abd516c63e077c07d
  HEAD_REF
  master)

vcpkg_configure_cmake(
  SOURCE_PATH
  ${SOURCE_PATH}
  DISABLE_PARALLEL_CONFIGURE
  PREFER_NINJA
  OPTIONS
  -DENTITYX_BUILD_TESTING=false
  -DENTITYX_BUILD_SHARED=0)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/COPYING
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/entityx)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/entityx/COPYING
     ${CURRENT_PACKAGES_DIR}/share/entityx/copyright)
