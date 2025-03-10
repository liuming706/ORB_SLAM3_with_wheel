function(qt_submodule_installation)
  cmake_parse_arguments(_csc "" "OUT_SOURCE_PATH" "" ${ARGN})
  qt_download_submodule(OUT_SOURCE_PATH TARGET_SOURCE_PATH
                        ${_csc_UNPARSED_ARGUMENTS})
  if(QT_UPDATE_VERSION)
    set(VCPKG_POLICY_EMPTY_PACKAGE
        enabled
        PARENT_SCOPE)
  else()
    qt_build_submodule(${TARGET_SOURCE_PATH} ${_csc_UNPARSED_ARGUMENTS})
    qt_install_copyright(${TARGET_SOURCE_PATH})
  endif()
  if(DEFINED _csc_OUT_SOURCE_PATH)
    set(${_csc_OUT_SOURCE_PATH}
        ${TARGET_SOURCE_PATH}
        PARENT_SCOPE)
  endif()
endfunction()
