# This function modifies hardcoded RuntimeLibrary directives in Ice's .vcxproj
# files and downloads Ice Builder for MSBuild, which is required to generate C++
# files based on the interface definition files (.ice).

function(prepare_for_build ICE_SOURCE_DIR)

  message(
    "-- Modifying hardcoded 'RuntimeLibrary' directives in .vcxproj files")
  set(CPP_SOURCE_DIR "${ICE_SOURCE_DIR}/cpp/src")
  file(GLOB_RECURSE PROJ_FILES "${CPP_SOURCE_DIR}/*.vcxproj")
  foreach(PROJ_FILE ${PROJ_FILES})
    file(READ ${PROJ_FILE} PROJ_FILE_CONTENT)
    string(
      REGEX
      REPLACE
        "<Target Name=\"EnsureNuGetPackageBuildImports\" BeforeTargets=\"PrepareForBuild\">"
        "<Target Name=\"EnsureNuGetPackageBuildImports\" BeforeTargets=\"PrepareForBuild\" Condition=\"'$(UseVcpkg)' != 'yes'\">"
        PROJ_FILE_CONTENT
        "${PROJ_FILE_CONTENT}")

    if((NOT ${PROJ_FILE} MATCHES ".*slice\.vcxproj")
       AND (NOT ${PROJ_FILE} MATCHES ".*iceutil\.vcxproj")
       AND (NOT ${PROJ_FILE} MATCHES ".*slice2cpp\.vcxproj"))

      if(${VCPKG_LIBRARY_LINKAGE} STREQUAL "static")
        string(
          REGEX
          REPLACE "<ConfigurationType>DynamicLibrary</ConfigurationType>"
                  "<ConfigurationType>StaticLibrary</ConfigurationType>"
                  PROJ_FILE_CONTENT "${PROJ_FILE_CONTENT}")
      else()
        string(
          REGEX
          REPLACE "<ConfigurationType>StaticLibrary</ConfigurationType>"
                  "<ConfigurationType>DynamicLibrary</ConfigurationType>"
                  PROJ_FILE_CONTENT "${PROJ_FILE_CONTENT}")
      endif()
    endif()

    file(WRITE ${PROJ_FILE} "${PROJ_FILE_CONTENT}")

    vcpkg_execute_required_process(
      COMMAND
      pwsh
      ${CURRENT_PORT_DIR}/change_to_mt.ps1
      ${PROJ_FILE}
      ${VCPKG_CRT_LINKAGE}
      WORKING_DIRECTORY
      ${SOURCE_PATH}
      LOGNAME
      change_to_mt-${TARGET_TRIPLET}-rel)
  endforeach()

  set(ICE_CPP_MSBUILD_PACKAGES_DIR "${ICE_SOURCE_DIR}/cpp/msbuild/packages")
  set(ICE_BUILDER_DEST_DIRECTORY
      "${ICE_CPP_MSBUILD_PACKAGES_DIR}/zeroc.icebuilder.msbuild.5.0.7")
  if(NOT EXISTS "${ICE_BUILDER_DEST_DIRECTORY}")
    message("-- Making Ice Builder for MSBuild available")
    vcpkg_download_distfile(
      ICE_BUILDER_MSBUILD_ARCHIVE
      URLS
      https://globalcdn.nuget.org/packages/zeroc.icebuilder.msbuild.5.0.7.nupkg
      FILENAME
      zeroc.icebuilder.msbuild.5.0.7.zip
      SHA512
      d4afed8a3c67daf2e1cde09e7747ec9f088fa1354069bb7c7782c1089ea0f4e50b669f45a88502ad341dbccafbc1394d74fe764479f25bf4be1d3f70e66cb174
    )

    vcpkg_extract_source_archive(
      ICE_BUILDER_MSBUILD_DIRECTORY ARCHIVE "${ICE_BUILDER_MSBUILD_ARCHIVE}"
      NO_REMOVE_ONE_LEVEL SOURCE_BASE icebuilder)

    file(MAKE_DIRECTORY "${ICE_SOURCE_DIR}/cpp/msbuild/packages")
    file(RENAME "${ICE_BUILDER_MSBUILD_DIRECTORY}"
         "${ICE_BUILDER_DEST_DIRECTORY}")
  endif()

endfunction()
