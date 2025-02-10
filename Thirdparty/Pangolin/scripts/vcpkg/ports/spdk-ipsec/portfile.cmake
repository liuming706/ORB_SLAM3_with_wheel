if(NOT VCPKG_CMAKE_SYSTEM_NAME)
  set(EXEC_ENV "Windows")
else()
  set(EXEC_ENV "${VCPKG_CMAKE_SYSTEM_NAME}")
endif()

if(NOT VCPKG_TARGET_IS_LINUX)
  message(
    FATAL_ERROR
      "Intel(R) Multi-Buffer Crypto for IPsec Library currently only supports Linux/Windows platforms"
  )
  message(
    STATUS
      "Well, it is not true, but I didnt manage to get it working on Windows")
endif()

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86" OR VCPKG_TARGET_ARCHITECTURE
                                               STREQUAL "arm")
  message(
    FATAL_ERROR
      "Intel(R) Multi-Buffer Crypto for IPsec Library currently only supports x64 architecture"
  )
elseif(NOT VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
  message(FATAL_ERROR "Unsupported architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  spdk/intel-ipsec-mb
  REF
  spdk
  SHA512
  037fc382d9aa87b6645309f29cb761a584ed855c583638c9e27b5b7200ceb2ae21ad5adcc7c92b2b1d1387186a7fd2b5ae22f337a8f52dea3f6c35d8f90b42bd
  HEAD_REF
  master)

vcpkg_find_acquire_program(NASM)

execute_process(
  COMMAND "${NASM}" -v
  OUTPUT_VARIABLE NASM_OUTPUT
  ERROR_VARIABLE NASM_OUTPUT)
string(REGEX REPLACE "NASM version ([0-9]+\\.[0-9]+\\.[0-9]+).*" "\\1"
                     NASM_VERSION "${NASM_OUTPUT}")
if(NASM_VERSION VERSION_LESS 2.13.03)
  message(
    FATAL_ERROR
      "NASM version 2.13.03 (or newer) is required to build this package")
endif()

get_filename_component(NASM_PATH ${NASM} DIRECTORY)
vcpkg_add_to_path("${NASM_PATH}")

vcpkg_configure_cmake(
  SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR} PREFER_NINJA OPTIONS
  -DSOURCE_PATH=${SOURCE_PATH} -DEXEC_ENV=${VCPKG_CMAKE_SYSTEM_NAME})

vcpkg_install_cmake()

file(INSTALL ${SOURCE_PATH}/Release/lib/
     DESTINATION ${CURRENT_PACKAGES_DIR}/lib/spdk)
if(NOT VCPKG_BUILD_TYPE)
  file(INSTALL ${SOURCE_PATH}/Debug/lib/
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib/spdk)
endif()
file(INSTALL ${SOURCE_PATH}/Release/include/
     DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/spdk-ipsecConfig.cmake
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright)
