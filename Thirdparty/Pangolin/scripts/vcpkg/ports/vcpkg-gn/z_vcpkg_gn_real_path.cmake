include_guard(GLOBAL)

file(
  REAL_PATH
  "${CMAKE_CURRENT_LIST_DIR}/../../tools/vcpkg-gn/gn${CMAKE_EXECUTABLE_SUFFIX}"
  VCPKG_GN)
set(VCPKG_GN
    "${VCPKG_GN}"
    CACHE INTERNAL "")
