vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  TartanLlama/function_ref
  REF
  v1.0.0
  SHA512
  64324049021548361caa667a5ad61a8c0acc787d3966e5b132520da99af709970e37b5a5cb71f69523b6254c9d0d8bab441356e7a25880fe53a6998067c587bd
  HEAD_REF
  master)

vcpkg_from_github(
  OUT_SOURCE_PATH
  TL_CMAKE_SOURCE_DIR
  REPO
  TartanLlama/tl-cmake
  REF
  284c6a3f0f61823cc3871b0f193e8df699e2c4ce
  SHA512
  f611326d75d6e87e58cb05e91f9506b1d83e6fd3b214fe311c4c15604feabfb7a18bbf9c4b4c389a39d615eb468b1f4b15802ab9f44f334a12310cb183fa77a7
  HEAD_REF
  master)

vcpkg_configure_cmake(
  SOURCE_PATH
  ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
  -DFETCHCONTENT_FULLY_DISCONNECTED=ON
  -DFETCHCONTENT_SOURCE_DIR_TL_CMAKE=${TL_CMAKE_SOURCE_DIR}
  -DFUNCTION_REF_ENABLE_TESTS=OFF)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

# Handle copyright
file(
  INSTALL ${SOURCE_PATH}/COPYING
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/tl-function-ref
  RENAME copyright)
