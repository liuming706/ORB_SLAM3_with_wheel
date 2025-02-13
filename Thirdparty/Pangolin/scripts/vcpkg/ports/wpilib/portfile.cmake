vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  wpilibsuite/allwpilib
  REF
  35eb90c135eba994a2ca2cbd50a68c367910f4b6
  SHA512
  55bc608632ab67c097f3cce7c5ad9790b2b123a633c93bf5b4008f90bf79538cc142c911850d5f49b75e3a12f43ffad9f6f5f9bcdf1351cce7513ecc4b04e439
  PATCHES
  fix-dependency-libuv.patch)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  INVERTED_FEATURES
  cameraserver
  WITHOUT_CSCORE
  allwpilib
  WITHOUT_ALLWPILIB)

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  -DWITHOUT_JAVA=ON
  ${FEATURE_OPTIONS}
  -DUSE_VCPKG_LIBUV=ON
  -DUSE_VCPKG_EIGEN=ON
  -DFLAT_INSTALL_WPILIB=ON)
vcpkg_cmake_install()

file(COPY "${CURRENT_PACKAGES_DIR}/wpilib/include/ntcore/"
     DESTINATION "${CURRENT_PACKAGES_DIR}/include")
file(COPY "${CURRENT_PACKAGES_DIR}/wpilib/include/wpiutil/"
     DESTINATION "${CURRENT_PACKAGES_DIR}/include")

if("allwpilib" IN_LIST FEATURES)
  file(COPY "${CURRENT_PACKAGES_DIR}/wpilib/include/wpilibc/"
       DESTINATION "${CURRENT_PACKAGES_DIR}/include")
  file(COPY "${CURRENT_PACKAGES_DIR}/wpilib/include/hal/"
       DESTINATION "${CURRENT_PACKAGES_DIR}/include")
  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/include/gen")
endif()

if("cameraserver" IN_LIST FEATURES)
  file(COPY "${CURRENT_PACKAGES_DIR}/wpilib/include/cameraserver/"
       DESTINATION "${CURRENT_PACKAGES_DIR}/include")
  file(COPY "${CURRENT_PACKAGES_DIR}/wpilib/include/cscore/"
       DESTINATION "${CURRENT_PACKAGES_DIR}/include")
endif()

if(NOT VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  file(
    COPY "${CURRENT_PACKAGES_DIR}/wpilib/lib/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/bin"
    FILES_MATCHING
    PATTERN "*.dll")
  file(
    COPY "${CURRENT_PACKAGES_DIR}/debug/wpilib/lib/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin"
    FILES_MATCHING
    PATTERN "*.dll")

  file(
    COPY "${CURRENT_PACKAGES_DIR}/wpilib/lib/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/bin"
    FILES_MATCHING
    PATTERN "*.so")
  file(
    COPY "${CURRENT_PACKAGES_DIR}/debug/wpilib/lib/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin"
    FILES_MATCHING
    PATTERN "*.so")

  file(
    COPY "${CURRENT_PACKAGES_DIR}/wpilib/lib/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/bin"
    FILES_MATCHING
    PATTERN "*.dylib")
  file(
    COPY "${CURRENT_PACKAGES_DIR}/debug/wpilib/lib/"
    DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin"
    FILES_MATCHING
    PATTERN "*.dylib")
endif()

file(
  COPY "${CURRENT_PACKAGES_DIR}/wpilib/lib/"
  DESTINATION "${CURRENT_PACKAGES_DIR}/lib"
  FILES_MATCHING
  PATTERN "*.lib")
file(
  COPY "${CURRENT_PACKAGES_DIR}/debug/wpilib/lib/"
  DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib"
  FILES_MATCHING
  PATTERN "*.lib")

file(
  COPY "${CURRENT_PACKAGES_DIR}/wpilib/lib/"
  DESTINATION "${CURRENT_PACKAGES_DIR}/lib"
  FILES_MATCHING
  PATTERN "*.a")
file(
  COPY "${CURRENT_PACKAGES_DIR}/debug/wpilib/lib/"
  DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib"
  FILES_MATCHING
  PATTERN "*.a")

vcpkg_copy_pdbs()

file(
  INSTALL "${SOURCE_PATH}/LICENSE.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
