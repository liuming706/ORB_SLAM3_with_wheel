cmake_policy(PUSH)
cmake_policy(SET CMP0012 NEW)
cmake_policy(SET CMP0054 NEW)

list(REMOVE_ITEM ARGS "NO_MODULE" "CONFIG" "MODULE")
list(APPEND ARGS "CONFIG")
# The current port version should satisfy GDAL 3.0 ... 3.5
list(GET ARGS 1 vcpkg_gdal_maybe_version)
if(vcpkg_gdal_maybe_version MATCHES "(^3\$|^3[.][0-5])")
  list(REMOVE_AT ARGS "1")
endif()
unset(vcpkg_gdal_maybe_version)
_find_package(${ARGS} CONFIG)
if(GDAL_FOUND)
  get_filename_component(vcpkg_gdal_prefix "${CMAKE_CURRENT_LIST_DIR}/../.."
                         ABSOLUTE)
  set(GDAL_INCLUDE_DIR
      "${vcpkg_gdal_prefix}/include"
      CACHE INTERNAL "")
  set(GDAL_INCLUDE_DIRS "${GDAL_INCLUDE_DIR}")
  set(GDAL_LIBRARY
      GDAL::GDAL
      CACHE INTERNAL "")
  set(GDAL_LIBRARIES "${GDAL_LIBRARY}")
  unset(vcpkg_gdal_prefix)
endif()

cmake_policy(POP)
