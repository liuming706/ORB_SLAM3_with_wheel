include(SelectLibraryConfigurations)

_find_package(${ARGS})
if(Iconv_FOUND AND NOT Iconv_IS_BUILT_IN)
  find_path(
    CHARSET_INCLUDE_DIR
    NAMES "libcharset.h"
    HINTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/include")
  find_library(
    CHARSET_LIBRARY_DEBUG
    NAMES charsetd libcharsetd charset libcharset NAMES_PER_DIR
    PATH_SUFFIXES lib
    HINTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug")
  find_library(
    CHARSET_LIBRARY_RELEASE
    NAMES charset libcharset NAMES_PER_DIR
    PATH_SUFFIXES lib
    HINTS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}")
  select_library_configurations(CHARSET)
  if(NOT TARGET Iconv::Charset)
    add_library(Iconv::Charset INTERFACE IMPORTED)
    set_target_properties(
      Iconv::Charset
      PROPERTIES
        INTERFACE_LINK_LIBRARIES
        "\$<\$<NOT:\$<CONFIG:DEBUG>>:${CHARSET_LIBRARY_RELEASE}>;\$<\$<CONFIG:DEBUG>:${CHARSET_LIBRARY_DEBUG}>"
        INTERFACE_INCLUDE_DIRECTORIES "${CHARSET_INCLUDE_DIRS}")
  endif()
  if(CHARSET_LIBRARIES)
    list(APPEND Iconv_LIBRARIES ${CHARSET_LIBRARIES})
    if(TARGET Iconv::Iconv)
      set_property(
        TARGET Iconv::Iconv
        APPEND
        PROPERTY INTERFACE_LINK_LIBRARIES Iconv::Charset)
    endif()
  endif()
endif()
