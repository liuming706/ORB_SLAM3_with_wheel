if(VCPKG_CMAKE_SYSTEM_NAME AND NOT VCPKG_CMAKE_SYSTEM_NAME STREQUAL
                               "WindowsStore")
  set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
  return()
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  tronkko/dirent
  REF
  1.23.2
  SHA512
  e7a991445ee9ca8f1118753df559d28beb283b3c0d25edcfb23dd5322f2bdfeadffe802d0c908bb6d4dfc17bf5ec38bdecfa717319fb4e26682bee0ba0d14c5c
  HEAD_REF
  master)
file(INSTALL ${SOURCE_PATH}/include/
     DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/dirent
  RENAME copyright)
vcpkg_copy_pdbs()

set(VCPKG_POLICY_ALLOW_RESTRICTED_HEADERS enabled)
