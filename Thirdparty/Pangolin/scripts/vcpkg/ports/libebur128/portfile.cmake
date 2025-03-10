if((VCPKG_TARGET_ARCHITECTURE STREQUAL "arm" OR VCPKG_TARGET_ARCHITECTURE
                                                STREQUAL "arm64")
   AND VCPKG_TARGET_IS_WINDOWS)
  message(FATAL_ERROR "${PORT} does not support Windows ARM")
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  jiixyj/libebur128
  REF
  v1.2.6
  SHA512
  ab188c6d32cd14613119258313a8a3fb1167b55501c9f5b6d3ba738d674bc58f24ac3034c23d9730ed8dc3e95a23619bfb81719e4c79807a9a16c1a5b3423582
)
vcpkg_configure_cmake(SOURCE_PATH ${SOURCE_PATH} PREFER_NINJA OPTIONS
                      -DENABLE_INTERNAL_QUEUE_H=ON)
vcpkg_install_cmake()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(
  INSTALL ${SOURCE_PATH}/COPYING
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
