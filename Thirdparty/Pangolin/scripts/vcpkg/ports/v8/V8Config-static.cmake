include(CMakeFindDependencyMacro)
find_dependency(ICU REQUIRED COMPONENTS in uc dt)
find_dependency(ZLIB REQUIRED)
if(UNIX)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(GLIB2 glib-2.0 gobject-2.0 gmodule-2.0 gio-2.0
                    IMPORTED_TARGET)
  set(V8_IMPORTED_LINK_INTERFACE_LIBRARIES "ICU::in;ICU::uc;ICU::dt;ZLIB::ZLIB")
elseif(WIN32)
  set(V8_IMPORTED_LINK_INTERFACE_LIBRARIES
      "Winmm;DbgHelp;ZLIB::ZLIB;ICU::in;ICU::uc;ICU::dt")
endif()

get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
if(_IMPORT_PREFIX STREQUAL "/")
  set(_IMPORT_PREFIX "")
endif()

include(SelectLibraryConfigurations)

find_path(
  V8_INCLUDE_DIR
  NAMES v8.h
  PATH_SUFFIXES include)

if(EXISTS
   "${_IMPORT_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}v8_monolith${CMAKE_STATIC_LIBRARY_SUFFIX}"
)
  set(V8_LIBRARY_RELEASE
      "${_IMPORT_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}v8_monolith${CMAKE_STATIC_LIBRARY_SUFFIX}"
      CACHE FILEPATH "Release version of the V8 library location")
endif()
if(EXISTS
   "${_IMPORT_PREFIX}/debug/lib/${CMAKE_STATIC_LIBRARY_PREFIX}v8_monolith${CMAKE_STATIC_LIBRARY_SUFFIX}"
)
  set(V8_LIBRARY_DEBUG
      "${_IMPORT_PREFIX}/debug/lib/${CMAKE_STATIC_LIBRARY_PREFIX}v8_monolith${CMAKE_STATIC_LIBRARY_SUFFIX}"
      CACHE FILEPATH "Debug version of the V8 library location")
endif()
select_library_configurations(V8)

mark_as_advanced(V8_INCLUDE_DIR)

if(V8_INCLUDE_DIR AND EXISTS "${V8_INCLUDE_DIR}/v8-version.h")
  file(STRINGS "${V8_INCLUDE_DIR}/v8-version.h" V8_MAJOR_VERSION
       REGEX "^#define V8_MAJOR_VERSION [0-9]+.*$")
  string(REGEX REPLACE "^#define V8_MAJOR_VERSION ([0-9]+).*$" "\\1"
                       V8_MAJOR_VERSION "${V8_MAJOR_VERSION}")
  file(STRINGS "${V8_INCLUDE_DIR}/v8-version.h" V8_MINOR_VERSION
       REGEX "^#define V8_MINOR_VERSION [0-9]+.*$")
  string(REGEX REPLACE "^#define V8_MINOR_VERSION ([0-9]+).*$" "\\1"
                       V8_MINOR_VERSION "${V8_MINOR_VERSION}")
  file(STRINGS "${V8_INCLUDE_DIR}/v8-version.h" V8_BUILD_NUMBER
       REGEX "^#define V8_BUILD_NUMBER [0-9]+.*$")
  string(REGEX REPLACE "^#define V8_BUILD_NUMBER ([0-9]+).*$" "\\1"
                       V8_BUILD_NUMBER "${V8_BUILD_NUMBER}")
  file(STRINGS "${V8_INCLUDE_DIR}/v8-version.h" V8_PATCH_LEVEL
       REGEX "^#define V8_PATCH_LEVEL [0-9]+.*$")
  string(REGEX REPLACE "^#define V8_PATCH_LEVEL ([0-9]+).*$" "\\1"
                       V8_PATCH_LEVEL "${V8_PATCH_LEVEL}")
  set(V8_VERSION_STRING
      "${V8_MAJOR_VERSION}.${V8_MINOR_VERSION}.${V8_BUILD_NUMBER}.${V8_PATCH_LEVEL}"
  )
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(V8_COMPILE_DEFINITIONS "V8_COMPRESS_POINTERS;V8_31BIT_SMIS_ON_64BIT_ARCH")
else()
  set(V8_COMPILE_DEFINITIONS " ")
endif()

mark_as_advanced(V8_COMPILE_DEFINITIONS)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
  V8
  REQUIRED_VARS V8_LIBRARY V8_INCLUDE_DIR V8_COMPILE_DEFINITIONS
  VERSION_VAR V8_VERSION_STRING)
set(V8_LIBRARIES ${V8_LIBRARY})

mark_as_advanced(V8_LIBRARIES)

if(NOT TARGET V8::V8)
  add_library(V8::V8 STATIC IMPORTED)
  set_target_properties(
    V8::V8 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${V8_INCLUDE_DIR}"
                      INTERFACE_COMPILE_DEFINITIONS "${V8_COMPILE_DEFINITIONS}")
  if(MSVC)
    set_target_properties(V8::V8 PROPERTIES INTERFACE_COMPILE_OPTIONS
                                            "/MT$<$<CONFIG:Debug>:d>")
  endif()

  if(V8_LIBRARY_RELEASE)
    set_property(
      TARGET V8::V8
      APPEND
      PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
    set_target_properties(
      V8::V8
      PROPERTIES IMPORTED_LOCATION_RELEASE "${V8_LIBRARY_RELEASE}"
                 IMPORTED_LINK_INTERFACE_LIBRARIES_RELEASE
                 "${V8_IMPORTED_LINK_INTERFACE_LIBRARIES}")
  endif()

  if(V8_LIBRARY_DEBUG)
    set_property(
      TARGET V8::V8
      APPEND
      PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
    set_target_properties(
      V8::V8
      PROPERTIES IMPORTED_LOCATION_DEBUG "${V8_LIBRARY_DEBUG}"
                 IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG
                 "${V8_IMPORTED_LINK_INTERFACE_LIBRARIES}")
  endif()

  if(NOT V8_LIBRARY_RELEASE AND NOT V8_LIBRARY_DEBUG)
    set_property(
      TARGET V8::V8
      APPEND
      PROPERTY IMPORTED_LOCATION "${V8_LIBRARY}"
               IMPORTED_LINK_INTERFACE_LIBRARIES
               "${V8_IMPORTED_LINK_INTERFACE_LIBRARIES}")
  endif()
endif()
