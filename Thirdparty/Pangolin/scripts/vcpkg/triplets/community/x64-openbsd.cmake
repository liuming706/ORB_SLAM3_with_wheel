# Use with VCPKG_FORCE_SYSTEM_BINARIES=1 ./vcpkg install brotli

set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME OpenBSD)
