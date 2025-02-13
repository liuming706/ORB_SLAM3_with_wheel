vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  stevemk14ebr/PolyHook_2_0
  REF
  750e78f8d7ebfc291e1c0dce3a0763c3a4b86737
  SHA512
  c542288cfde258bcb54960593f2b596b6a967cf128a691e4b8ad699127567c58dc55ce2bbf21f4d3ccbaa2d794bcacd3540503b039ee58c614a854f13d51d30e
  HEAD_REF
  master)

vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  FEATURES
  capstone
  POLYHOOK_DISASM_CAPSTONE
  zydis
  POLYHOOK_DISASM_ZYDIS
  exception
  POLYHOOK_FEATURE_EXCEPTION
  detours
  POLYHOOK_FEATURE_DETOURS
  inlinentd
  POLYHOOK_FEATURE_INLINENTD
  pe
  POLYHOOK_FEATURE_PE
  virtuals
  POLYHOOK_FEATURE_VIRTUALS)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_SHARED_LIB)

if(VCPKG_CRT_LINKAGE STREQUAL "static")
  set(BUILD_STATIC_RUNTIME ON)
else()
  set(BUILD_STATIC_RUNTIME OFF)
endif()

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  ${FEATURE_OPTIONS}
  -DPOLYHOOK_BUILD_SHARED_LIB=${BUILD_SHARED_LIB}
  -DPOLYHOOK_BUILD_STATIC_RUNTIME=${BUILD_STATIC_RUNTIME}
  -DPOLYHOOK_USE_EXTERNAL_ASMJIT=ON
  -DPOLYHOOK_USE_EXTERNAL_CAPSTONE=ON
  -DPOLYHOOK_USE_EXTERNAL_ZYDIS=ON)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(PACKAGE_NAME PolyHook_2 CONFIG_PATH lib/PolyHook_2)

# Handle copyright
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
