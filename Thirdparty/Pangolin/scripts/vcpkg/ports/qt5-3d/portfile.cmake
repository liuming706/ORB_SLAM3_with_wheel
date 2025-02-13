include(${CURRENT_INSTALLED_DIR}/share/qt5/qt_port_functions.cmake)

set(OPTIONS -system-assimp)

if(VCPKG_TARGET_IS_WINDOWS)
  set(VCVER vc140 vc141 vc142 vc143)
  set(CRT mt md)
  set(DBG_NAMES)
  set(REL_NAMES)
  foreach(_ver IN LISTS VCVER)
    foreach(_crt IN LISTS CRT)
      list(APPEND DBG_NAMES assimp-${_ver}-${_crt}d)
      list(APPEND REL_NAMES assimp-${_ver}-${_crt})
    endforeach()
  endforeach()
endif()

find_library(
  ASSIMP_REL
  NAMES assimp ${REL_NAMES}
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  ASSIMP_DBG
  NAMES assimp assimpd ${DBG_NAMES}
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)

find_library(
  MINIZIP_REL
  NAMES minizip
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  MINIZIP_DBG
  NAMES minizip minizipd
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  KUBAZIP_REL
  NAMES kubazip
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  KUBAZIP_DBG
  NAMES kubazip kubazipd
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  JPEG_REL
  NAMES jpeg jpeg-static
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  JPEG_DBG
  NAMES jpeg jpeg-static jpegd jpeg-staticd
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  LIBPNG_REL
  NAMES png16 libpng16
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH) # Depends on zlib
find_library(
  LIBPNG_DBG
  NAMES png16 png16d libpng16 libpng16d
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  ZLIB_REL
  NAMES z zlib
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  ZLIB_DBG
  NAMES z zlib zd zlibd
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  PUGIXML_REL
  NAMES pugixml
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  PUGIXML_DBG
  NAMES pugixml pugixmld
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  POLY2TRI_REL
  NAMES poly2tri
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  POLY2TRI_DBG
  NAMES poly2tri poly2trid
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
find_library(
  BZ2_REL bz2
  PATHS "${CURRENT_INSTALLED_DIR}/lib"
  NO_DEFAULT_PATH)
find_library(
  BZ2_DBG bz2 bz2d
  PATHS "${CURRENT_INSTALLED_DIR}/debug/lib"
  NO_DEFAULT_PATH)
if(BZ2_REL)
  string(APPEND MINIZIP_REL " ${BZ2_REL}")
endif()
if(BZ2_DBG)
  string(APPEND MINIZIP_DBG " ${BZ2_DBG}")
endif()
if(VCPKG_TARGET_IS_WINDOWS)
  set(SYSTEM_LIBS "Advapi32.lib user32.lib gdi32.lib")
elseif(VCPKG_TARGET_IS_OSX)
  set(SYSTEM_LIBS
      "-framework OpenGL -framework Cocoa -framework Carbon -framework IOKit -framework AppKit"
  )
else()
  set(SYSTEM_LIBS "-lGL -lXxf86vm -lX11")
endif()
set(OPT_REL
    "ASSIMP_LIBS=${ASSIMP_REL} ${PUGIXML_REL} ${POLY2TRI_REL} ${JPEG_REL} ${LIBPNG_REL} ${KUBAZIP_REL} ${MINIZIP_REL} ${ZLIB_REL} ${SYSTEM_LIBS}"
)
set(OPT_DBG
    "ASSIMP_LIBS=${ASSIMP_DBG} ${PUGIXML_DBG} ${POLY2TRI_DBG} ${JPEG_DBG} ${LIBPNG_DBG} ${KUBAZIP_DBG} ${MINIZIP_DBG} ${ZLIB_DBG} ${SYSTEM_LIBS}"
)

qt_submodule_installation(BUILD_OPTIONS ${OPTIONS} BUILD_OPTIONS_RELEASE
                          ${OPT_REL} BUILD_OPTIONS_DEBUG ${OPT_DBG})
