vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  nats-io/nats.c
  REF
  b26143da7566e816db66e86f6336ebf5c226c4ad # v3.4.1
  SHA512
  6422d3d5b59a700ac56730870dab1bbdadd8f85c9a0cef2c685cdd36189b1689d04d5a710500fbc5299445ca32df9434b404fae3018e8266c284aa34259f110a
  HEAD_REF
  master)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS FEATURES "streaming"
                     NATS_BUILD_STREAMING)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
  list(APPEND OPTIONS -DNATS_BUILD_LIB_SHARED=ON)
  list(APPEND OPTIONS -DNATS_BUILD_LIB_STATIC=OFF)
  list(APPEND OPTIONS -DBUILD_TESTING=OFF)
  list(APPEND OPTIONS -DNATS_BUILD_USE_SODIUM=ON)
else()
  list(APPEND OPTIONS -DNATS_BUILD_LIB_SHARED=OFF)
  list(APPEND OPTIONS -DNATS_BUILD_LIB_STATIC=ON)
  list(APPEND OPTIONS -DBUILD_TESTING=ON)
  if(VCPKG_TARGET_IS_WINDOWS)
    list(APPEND OPTIONS -DNATS_BUILD_USE_SODIUM=OFF)
  else()
    list(APPEND OPTIONS -DNATS_BUILD_USE_SODIUM=ON)
  endif()
endif()

vcpkg_cmake_configure(
  SOURCE_PATH
  ${SOURCE_PATH}
  OPTIONS
  ${FEATURE_OPTIONS}
  ${OPTIONS}
  -DNATS_BUILD_TLS_USE_OPENSSL_1_1_API=ON
  -DNATS_BUILD_EXAMPLES=OFF)

vcpkg_cmake_install(ADD_BIN_TO_PATH)

if(VCPKG_TARGET_IS_WINDOWS)
  if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/nats.dll")
      file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/bin")
      file(RENAME "${CURRENT_PACKAGES_DIR}/lib/nats.dll"
           "${CURRENT_PACKAGES_DIR}/bin/nats.dll")
    endif()
    if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/natsd.dll")
      file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/bin")
      file(RENAME "${CURRENT_PACKAGES_DIR}/debug/lib/natsd.dll"
           "${CURRENT_PACKAGES_DIR}/debug/bin/natsd.dll")
    endif()
  endif()
endif()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

if(VCPKG_TARGET_IS_WINDOWS)
  if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    if(EXISTS "${CURRENT_PACKAGES_DIR}/share/cnats/cnats-config-debug.cmake")
      vcpkg_replace_string(
        "${CURRENT_PACKAGES_DIR}/share/cnats/cnats-config-debug.cmake"
        "\${_IMPORT_PREFIX}/debug/lib/natsd.dll"
        "\${_IMPORT_PREFIX}/debug/bin/natsd.dll")
    endif()
    if(EXISTS "${CURRENT_PACKAGES_DIR}/share/cnats/cnats-config-release.cmake")
      vcpkg_replace_string(
        "${CURRENT_PACKAGES_DIR}/share/cnats/cnats-config-release.cmake"
        "\${_IMPORT_PREFIX}/lib/nats.dll" "\${_IMPORT_PREFIX}/bin/nats.dll")
    endif()
  endif()
endif()

vcpkg_fixup_pkgconfig()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
