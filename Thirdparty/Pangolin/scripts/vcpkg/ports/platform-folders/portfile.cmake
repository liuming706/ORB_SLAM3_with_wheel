vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(TARGET_BUILD_PATH "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}")
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  sago007/PlatformFolders
  REF
  4.1.0
  SHA512
  B2C7983399D9EAA8EF95F45E51B7B70626466FC14A0E53C8B497E683D63E40683CC995C75FC9529C7E969BB802CF9C92051B663901326985722AEBF7618C48EB
  HEAD_REF
  master)

vcpkg_configure_cmake(SOURCE_PATH "${SOURCE_PATH}" PREFER_NINJA OPTIONS
                      -DBUILD_TESTING=OFF)

vcpkg_install_cmake()
if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
  file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/bin")
  file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/bin")
  file(INSTALL "${TARGET_BUILD_PATH}-rel/platform_folders.dll"
       DESTINATION "${CURRENT_PACKAGES_DIR}/bin/")
  file(INSTALL "${TARGET_BUILD_PATH}-dbg/platform_folders.dll"
       DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin/")
endif()

if(VCPKG_TARGET_IS_WINDOWS
   OR VCPKG_TARGET_IS_UWP
   OR VCPKG_TARGET_IS_MinGW)
  vcpkg_fixup_cmake_targets(CONFIG_PATH cmake/ TARGET_PATH
                            /share/platform_folders)
else()
  vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/ TARGET_PATH /share/)
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)

vcpkg_copy_pdbs()
