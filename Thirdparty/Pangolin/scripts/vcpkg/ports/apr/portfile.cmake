set(VERSION 1.7.0)

vcpkg_download_distfile(
  ARCHIVE
  URLS
  "https://www.apache.org/dist/apr/apr-${VERSION}.tar.bz2"
  FILENAME
  "apr-${VERSION}.tar.bz2"
  SHA512
  3dc42d5caf17aab16f5c154080f020d5aed761e22db4c5f6506917f6bfd2bf8becfb40af919042bd4ce1077d5de74aa666f5edfba7f275efba78e8893c115148
)

vcpkg_extract_source_archive_ex(
  OUT_SOURCE_PATH
  SOURCE_PATH
  ARCHIVE
  "${ARCHIVE}"
  PATCHES
  fix-configcmake.patch
  unglue.patch)

if(VCPKG_TARGET_IS_WINDOWS)
  vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS FEATURES
                       private-headers APR_INSTALL_PRIVATE_H)

  vcpkg_cmake_configure(
    SOURCE_PATH
    "${SOURCE_PATH}"
    OPTIONS
    -DINSTALL_PDB=OFF
    -DMIN_WINDOWS_VER=Windows7
    -DAPR_HAVE_IPV6=ON
    ${FEATURE_OPTIONS})

  vcpkg_cmake_install()
  vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-apr CONFIG_PATH
                           share/unofficial-apr)
  # There is no way to suppress installation of the headers in debug builds.
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

  vcpkg_copy_pdbs()
else()
  # To cross-compile you will need a triplet file that locates the tool chain
  # and sets --host and --cache parameters of "./configure". The
  # ${VCPKG_PLATFORM_TOOLSET}.cache file must have been generated on the
  # targeted host using "./configure -C". For example, to target
  # aarch64-linux-gnu, triplets/aarch64-linux-gnu.cmake should contain (beyond
  # the standard content): set(VCPKG_PLATFORM_TOOLSET aarch64-linux-gnu)
  # set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE
  # ${MY_CROSS_DIR}/cmake/Toolchain-${VCPKG_PLATFORM_TOOLSET}.cmake)
  # set(CONFIGURE_PARAMETER_1 --host=${VCPKG_PLATFORM_TOOLSET})
  # set(CONFIGURE_PARAMETER_2
  # --cache-file=${MY_CROSS_DIR}/autoconf/${VCPKG_PLATFORM_TOOLSET}.cache)
  if(CONFIGURE_PARAMETER_1)
    message(
      STATUS
        "Configuring apr with ${CONFIGURE_PARAMETER_1} ${CONFIGURE_PARAMETER_2} ${CONFIGURE_PARAMETER_3}"
    )
  else()
    message(STATUS "Configuring apr")
  endif()
  set(ENV{CFLAGS} "$ENV{CFLAGS} -Wno-error=implicit-function-declaration")
  vcpkg_configure_make(
    SOURCE_PATH
    "${SOURCE_PATH}"
    OPTIONS
    "--prefix=${CURRENT_INSTALLED_DIR}"
    "${CONFIGURE_PARAMETER_1}"
    "${CONFIGURE_PARAMETER_2}"
    "${CONFIGURE_PARAMETER_3}")

  vcpkg_install_make()

  if(NOT VCPKG_BUILD_TYPE)
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/apr-1.pc"
                         "-lapr-\${APR_MAJOR_VERSION}" "-lapr-1")
  endif()

  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/lib/pkgconfig/apr-1.pc"
                       "-lapr-\${APR_MAJOR_VERSION}" "-lapr-1")
  vcpkg_fixup_pkgconfig(SYSTEM_LIBRARIES pthread rt dl uuid crypt)

  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/apr-1-config"
                       "\"${CURRENT_INSTALLED_DIR}\"" "`dirname $0`/../../..")
  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/apr-1-config"
                       "APR_SOURCE_DIR=\"${SOURCE_PATH}\"" "")
  vcpkg_replace_string(
    "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/apr-1-config"
    "APR_BUILD_DIR=\"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel\"" "")

  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/build-1/libtool"
                       "${CURRENT_INSTALLED_DIR}/lib" "")
  vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/build-1/libtool"
                       "${CURRENT_INSTALLED_DIR}/debug/lib" "")
  if(NOT VCPKG_BUILD_TYPE)
    vcpkg_replace_string(
      "${CURRENT_PACKAGES_DIR}/tools/${PORT}/debug/bin/apr-1-config"
      "\"${CURRENT_INSTALLED_DIR}/debug\"" "`dirname $0`/../../../..")
    vcpkg_replace_string(
      "${CURRENT_PACKAGES_DIR}/tools/${PORT}/debug/bin/apr-1-config"
      "APR_SOURCE_DIR=\"${SOURCE_PATH}\"" "")
    vcpkg_replace_string(
      "${CURRENT_PACKAGES_DIR}/tools/${PORT}/debug/bin/apr-1-config"
      "APR_BUILD_DIR=\"${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg\"" "")

    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/build-1/libtool"
                         "${CURRENT_INSTALLED_DIR}/lib" "")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/build-1/libtool"
                         "${CURRENT_INSTALLED_DIR}/debug/lib" "")
  endif()
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
endif()

# Handle copyright
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
