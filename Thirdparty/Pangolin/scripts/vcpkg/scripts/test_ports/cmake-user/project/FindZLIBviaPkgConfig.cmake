# `pkgconf` is not recognized before CMake 3.22
find_program(PKG_CONFIG_EXECUTABLE NAMES pkgconf REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_ZLIB zlib)
if(PC_ZLIB_FOUND)
  if(NOT PC_ZLIB_LDFLAGS)
    message(SEND_ERROR "ZLIBviaPkgConfig_LIBRARIES is empty")
  endif()
  set(ZLIBviaPkgConfig_LIBRARIES "${PC_ZLIB_LDFLAGS}")
  set(ZLIBviaPkgConfig_FOUND "${PC_ZLIB_FOUND}")
endif()
