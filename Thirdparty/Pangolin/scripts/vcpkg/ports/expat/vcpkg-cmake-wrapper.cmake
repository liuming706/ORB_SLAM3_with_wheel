include(SelectLibraryConfigurations)

set(EXPATNAMES expat expatw libexpat libexpatw)
set(DEBUGNAMES)
foreach(_CRT "" MT MD)
  foreach(name IN LISTS EXPATNAMES)
    list(APPEND EXPATNAMES ${name}${_CRT})
    list(APPEND DEBUGNAMES ${name}d${_CRT})
  endforeach()
endforeach()

find_library(
  EXPAT_LIBRARY_DEBUG
  NAMES ${DEBUGNAMES} ${EXPATNAMES} NAMES_PER_DIR
  PATH_SUFFIXES lib
  PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug"
  NO_DEFAULT_PATH)
find_library(
  EXPAT_LIBRARY_RELEASE
  NAMES ${EXPATNAMES} NAMES_PER_DIR
  PATH_SUFFIXES lib
  PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}"
  NO_DEFAULT_PATH)
select_library_configurations(EXPAT)
set(EXPAT_LIBRARY
    "${EXPAT_LIBRARIES}"
    CACHE STRING "" FORCE)
_find_package(${ARGS})
if(EXPAT_FOUND AND TARGET EXPAT::EXPAT)
  if(EXPAT_LIBRARY_DEBUG)
    set_target_properties(EXPAT::EXPAT PROPERTIES IMPORTED_LOCATION_DEBUG
                                                  "${EXPAT_LIBRARY_DEBUG}")
  endif()
  if(EXPAT_LIBRARY_RELEASE)
    set_target_properties(EXPAT::EXPAT PROPERTIES IMPORTED_LOCATION_RELEASE
                                                  "${EXPAT_LIBRARY_RELEASE}")
  endif()
endif()

unset(EXPATNAMES)
unset(DEBUGNAMES)
