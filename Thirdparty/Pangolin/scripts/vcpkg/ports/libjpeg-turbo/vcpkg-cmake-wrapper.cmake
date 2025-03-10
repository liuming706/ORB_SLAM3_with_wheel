cmake_policy(PUSH)
cmake_policy(SET CMP0012 NEW)
cmake_policy(SET CMP0054 NEW)
find_path(
  JPEG_INCLUDE_DIR
  NAMES jpeglib.h
  PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include"
  NO_DEFAULT_PATH)
find_library(
  JPEG_LIBRARY_RELEASE
  NAMES jpeg
  PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib"
  NO_DEFAULT_PATH)
find_library(
  JPEG_LIBRARY_DEBUG
  NAMES jpeg
  PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib"
  NO_DEFAULT_PATH)
if(CMAKE_VERSION VERSION_LESS 3.12 AND CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(JPEG_LIBRARY
      "${JPEG_LIBRARY_DEBUG}"
      CACHE FILEPATH "")
endif()
_find_package(${ARGS})
if(JPEG_FOUND AND NOT TARGET JPEG::JPEG)
  # Backfill JPEG::JPEG to versions of cmake before 3.12
  add_library(JPEG::JPEG UNKNOWN IMPORTED)
  if(DEFINED JPEG_INCLUDE_DIRS)
    set_target_properties(JPEG::JPEG PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
                                                "${JPEG_INCLUDE_DIRS}")
  endif()
  if(EXISTS "${JPEG_LIBRARY}")
    set_target_properties(
      JPEG::JPEG PROPERTIES IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                            IMPORTED_LOCATION "${JPEG_LIBRARY}")
  endif()
  if(EXISTS "${JPEG_LIBRARY_RELEASE}")
    set_property(
      TARGET JPEG::JPEG
      APPEND
      PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
    set_target_properties(
      JPEG::JPEG PROPERTIES IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C"
                            IMPORTED_LOCATION_RELEASE "${JPEG_LIBRARY_RELEASE}")
  endif()
  if(EXISTS "${JPEG_LIBRARY_DEBUG}")
    set_property(
      TARGET JPEG::JPEG
      APPEND
      PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
    set_target_properties(
      JPEG::JPEG PROPERTIES IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
                            IMPORTED_LOCATION_DEBUG "${JPEG_LIBRARY_DEBUG}")
  endif()
endif()
cmake_policy(POP)
