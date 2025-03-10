# header-only library

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  pfultz2/Linq
  REF
  7ff0a73fed52be5e11df3d79128ce7b11f430af2
  SHA512
  6768e28bf17568436b4c3fed18f6b1edbe048b871ebee25580419b805498beb0800e473ecdc5acc0f9f89bec47d16fd3806018ce6395bdf14a8e2975cde9381f
  HEAD_REF
  master)

vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA OPTIONS
                      -DBUILD_TESTING=OFF)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/linq TARGET_PATH share/linq)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug ${CURRENT_PACKAGES_DIR}/lib)

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE
               ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
