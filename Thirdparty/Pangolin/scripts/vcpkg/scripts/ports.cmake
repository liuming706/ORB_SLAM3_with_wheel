cmake_minimum_required(VERSION 3.21)

set(SCRIPTS
    "${CMAKE_CURRENT_LIST_DIR}"
    CACHE PATH "Location to stored scripts")
list(APPEND CMAKE_MODULE_PATH "${SCRIPTS}/cmake")
include("${SCRIPTS}/cmake/execute_process.cmake")
include("${SCRIPTS}/cmake/vcpkg_acquire_msys.cmake")
include("${SCRIPTS}/cmake/vcpkg_add_to_path.cmake")
include("${SCRIPTS}/cmake/vcpkg_apply_patches.cmake")
include("${SCRIPTS}/cmake/vcpkg_backup_restore_env_vars.cmake")
include("${SCRIPTS}/cmake/vcpkg_build_cmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_build_make.cmake")
include("${SCRIPTS}/cmake/vcpkg_build_msbuild.cmake")
include("${SCRIPTS}/cmake/vcpkg_build_ninja.cmake")
include("${SCRIPTS}/cmake/vcpkg_build_nmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_build_qmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_buildpath_length_warning.cmake")
include("${SCRIPTS}/cmake/vcpkg_check_features.cmake")
include("${SCRIPTS}/cmake/vcpkg_check_linkage.cmake")
include("${SCRIPTS}/cmake/vcpkg_clean_executables_in_bin.cmake")
include("${SCRIPTS}/cmake/vcpkg_clean_msbuild.cmake")
include("${SCRIPTS}/cmake/vcpkg_configure_cmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_configure_gn.cmake")
include("${SCRIPTS}/cmake/vcpkg_configure_make.cmake")
include("${SCRIPTS}/cmake/vcpkg_configure_meson.cmake")
include("${SCRIPTS}/cmake/vcpkg_configure_qmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_copy_pdbs.cmake")
include("${SCRIPTS}/cmake/vcpkg_copy_tool_dependencies.cmake")
include("${SCRIPTS}/cmake/vcpkg_copy_tools.cmake")
include("${SCRIPTS}/cmake/vcpkg_download_distfile.cmake")
include("${SCRIPTS}/cmake/vcpkg_execute_build_process.cmake")
include("${SCRIPTS}/cmake/vcpkg_execute_required_process.cmake")
include("${SCRIPTS}/cmake/vcpkg_execute_required_process_repeat.cmake")
include("${SCRIPTS}/cmake/vcpkg_extract_source_archive.cmake")
include("${SCRIPTS}/cmake/vcpkg_extract_source_archive_ex.cmake")
include("${SCRIPTS}/cmake/vcpkg_fail_port_install.cmake")
include("${SCRIPTS}/cmake/vcpkg_find_acquire_program.cmake")
include("${SCRIPTS}/cmake/vcpkg_fixup_cmake_targets.cmake")
include("${SCRIPTS}/cmake/vcpkg_fixup_pkgconfig.cmake")
include("${SCRIPTS}/cmake/vcpkg_from_bitbucket.cmake")
include("${SCRIPTS}/cmake/vcpkg_from_git.cmake")
include("${SCRIPTS}/cmake/vcpkg_from_github.cmake")
include("${SCRIPTS}/cmake/vcpkg_from_gitlab.cmake")
include("${SCRIPTS}/cmake/vcpkg_from_sourceforge.cmake")
include("${SCRIPTS}/cmake/vcpkg_get_program_files_platform_bitness.cmake")
include("${SCRIPTS}/cmake/vcpkg_get_windows_sdk.cmake")
include("${SCRIPTS}/cmake/vcpkg_host_path_list.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_cmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_copyright.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_gn.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_make.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_meson.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_msbuild.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_nmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_install_qmake.cmake")
include("${SCRIPTS}/cmake/vcpkg_list.cmake")
include("${SCRIPTS}/cmake/vcpkg_minimum_required.cmake")
include("${SCRIPTS}/cmake/vcpkg_replace_string.cmake")
include("${SCRIPTS}/cmake/vcpkg_test_cmake.cmake")

include("${SCRIPTS}/cmake/z_vcpkg_apply_patches.cmake")
include("${SCRIPTS}/cmake/z_vcpkg_forward_output_variable.cmake")
include("${SCRIPTS}/cmake/z_vcpkg_function_arguments.cmake")
include("${SCRIPTS}/cmake/z_vcpkg_get_cmake_vars.cmake")
include("${SCRIPTS}/cmake/z_vcpkg_prettify_command_line.cmake")
include("${SCRIPTS}/cmake/z_vcpkg_setup_pkgconfig_path.cmake")

function(debug_message)
  if(PORT_DEBUG)
    z_vcpkg_function_arguments(ARGS)
    list(JOIN ARGS " " ARG_STRING)
    message(STATUS "[DEBUG] " "${ARG_STRING}")
  endif()
endfunction()
function(z_vcpkg_deprecation_message)
  z_vcpkg_function_arguments(ARGS)
  list(JOIN ARGS " " ARG_STRING)
  message(DEPRECATION "${ARG_STRING}")
endfunction()

option(
  _VCPKG_PROHIBIT_BACKCOMPAT_FEATURES
  "Controls whether use of a backcompat only support feature fails the build.")
if(_VCPKG_PROHIBIT_BACKCOMPAT_FEATURES)
  set(Z_VCPKG_BACKCOMPAT_MESSAGE_LEVEL "FATAL_ERROR")
else()
  set(Z_VCPKG_BACKCOMPAT_MESSAGE_LEVEL "WARNING")
endif()

vcpkg_minimum_required(VERSION 2021-11-02)

file(TO_CMAKE_PATH "${BUILDTREES_DIR}" BUILDTREES_DIR)
file(TO_CMAKE_PATH "${PACKAGES_DIR}" PACKAGES_DIR)

set(CURRENT_INSTALLED_DIR
    "${_VCPKG_INSTALLED_DIR}/${TARGET_TRIPLET}"
    CACHE PATH "Location to install final packages")

if(PORT)
  set(CURRENT_BUILDTREES_DIR "${BUILDTREES_DIR}/${PORT}")
  set(CURRENT_PACKAGES_DIR "${PACKAGES_DIR}/${PORT}_${TARGET_TRIPLET}")
endif()

if(CMD STREQUAL "BUILD")
  set(CMAKE_TRIPLET_FILE "${TARGET_TRIPLET_FILE}")
  if(NOT EXISTS "${CMAKE_TRIPLET_FILE}")
    message(
      FATAL_ERROR
        "Unsupported target triplet. Triplet file does not exist: ${CMAKE_TRIPLET_FILE}"
    )
  endif()

  if(NOT DEFINED CURRENT_PORT_DIR)
    message(FATAL_ERROR "CURRENT_PORT_DIR was not defined")
  endif()
  file(TO_CMAKE_PATH "${CURRENT_PORT_DIR}" CURRENT_PORT_DIR)
  if(NOT EXISTS "${CURRENT_PORT_DIR}")
    message(
      FATAL_ERROR
        "Cannot find port: ${PORT}\n  Directory does not exist: ${CURRENT_PORT_DIR}"
    )
  endif()
  if(NOT EXISTS "${CURRENT_PORT_DIR}/portfile.cmake")
    message(
      FATAL_ERROR "Port is missing portfile: ${CURRENT_PORT_DIR}/portfile.cmake"
    )
  endif()
  if(NOT EXISTS "${CURRENT_PORT_DIR}/CONTROL"
     AND NOT EXISTS "${CURRENT_PORT_DIR}/vcpkg.json")
    message(
      FATAL_ERROR
        "Port is missing control or manifest file: ${CURRENT_PORT_DIR}/{CONTROL,vcpkg.json}"
    )
  endif()

  unset(PACKAGES_DIR)
  unset(BUILDTREES_DIR)

  if(EXISTS "${CURRENT_PACKAGES_DIR}")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}")
    if(EXISTS "${CURRENT_PACKAGES_DIR}")
      message(
        FATAL_ERROR
          "Unable to remove directory: ${CURRENT_PACKAGES_DIR}\n  Files are likely in use."
      )
    endif()
  endif()
  file(MAKE_DIRECTORY "${CURRENT_BUILDTREES_DIR}" "${CURRENT_PACKAGES_DIR}")

  include("${CMAKE_TRIPLET_FILE}")

  if(DEFINED VCPKG_PORT_CONFIGS)
    foreach(VCPKG_PORT_CONFIG IN LISTS VCPKG_PORT_CONFIGS)
      include("${VCPKG_PORT_CONFIG}")
    endforeach()
  endif()

  set(HOST_TRIPLET "${_HOST_TRIPLET}")
  set(CURRENT_HOST_INSTALLED_DIR
      "${_VCPKG_INSTALLED_DIR}/${HOST_TRIPLET}"
      CACHE PATH "Location to install final packages for the host")

  set(TRIPLET_SYSTEM_ARCH "${VCPKG_TARGET_ARCHITECTURE}")
  include("${SCRIPTS}/cmake/vcpkg_common_definitions.cmake")

  set(Z_VCPKG_ERROR_LOG_COLLECTION_FILE
      "${CURRENT_BUILDTREES_DIR}/error-logs-${TARGET_TRIPLET}.txt")
  file(REMOVE "${Z_VCPKG_ERROR_LOG_COLLECTION_FILE}")

  include("${CURRENT_PORT_DIR}/portfile.cmake")
  if(DEFINED PORT)
    if(VCPKG_FIXUP_ELF_RPATH)
      include("${SCRIPTS}/cmake/z_vcpkg_fixup_rpath.cmake")
    endif()
    include("${SCRIPTS}/build_info.cmake")
  endif()
elseif(CMD STREQUAL "CREATE")
  if(NOT DEFINED PORT_PATH)
    set(PORT_PATH "${VCPKG_ROOT_DIR}/ports/${PORT}")
  endif()
  file(TO_NATIVE_PATH "${PORT_PATH}" NATIVE_PORT_PATH)
  set(PORTFILE_PATH "${PORT_PATH}/portfile.cmake")
  file(TO_NATIVE_PATH "${PORTFILE_PATH}" NATIVE_PORTFILE_PATH)
  set(MANIFEST_PATH "${PORT_PATH}/vcpkg.json")
  file(TO_NATIVE_PATH "${MANIFEST_PATH}" NATIVE_MANIFEST_PATH)

  if(EXISTS "${PORTFILE_PATH}")
    message(FATAL_ERROR "Portfile already exists: '${NATIVE_PORTFILE_PATH}'")
  endif()
  if(NOT FILENAME)
    get_filename_component(FILENAME "${URL}" NAME)
  endif()
  string(REGEX REPLACE "(\\.(zip|gz|tar|tgz|bz2))+\$" "" ROOT_NAME
                       "${FILENAME}")

  set(DOWNLOAD_PATH "${DOWNLOADS}/${FILENAME}")
  file(TO_NATIVE_PATH "${DOWNLOAD_PATH}" NATIVE_DOWNLOAD_PATH)

  if(EXISTS "${DOWNLOAD_PATH}")
    message(STATUS "Using pre-downloaded: ${NATIVE_DOWNLOAD_PATH}")
    message(
      STATUS "If this is not desired, delete the file and ${NATIVE_PORT_PATH}")
  else()
    message(STATUS "Downloading ${URL} -> ${FILENAME}...")
    file(DOWNLOAD "${URL}" "${DOWNLOAD_PATH}" STATUS download_status)
    list(GET download_status 0 status_code)
    if(NOT "${download_status}" EQUAL "0")
      message(
        FATAL_ERROR "Downloading ${URL}... Failed. Status: ${download_status}")
    endif()
  endif()
  file(SHA512 "${DOWNLOAD_PATH}" SHA512)

  file(MAKE_DIRECTORY "${PORT_PATH}")
  configure_file("${SCRIPTS}/templates/portfile.in.cmake" "${PORTFILE_PATH}"
                 @ONLY)
  configure_file("${SCRIPTS}/templates/vcpkg.json.in" "${MANIFEST_PATH}" @ONLY)

  message(STATUS "Generated portfile: ${NATIVE_PORTFILE_PATH}")
  message(STATUS "Generated manifest: ${NATIVE_MANIFEST_PATH}")
  message(STATUS "To launch an editor for these new files, run")
  message(STATUS "    .\\vcpkg edit ${PORT}")
endif()
