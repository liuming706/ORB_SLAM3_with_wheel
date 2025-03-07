function(qt_fix_prl PACKAGE_DIR PRL_FILES)
  file(TO_CMAKE_PATH "${PACKAGE_DIR}/lib" CMAKE_LIB_PATH)
  file(TO_CMAKE_PATH "${PACKAGE_DIR}/include/qt5" CMAKE_INCLUDE_PATH)
  file(TO_CMAKE_PATH "${PACKAGE_DIR}/include" CMAKE_INCLUDE_PATH2)
  file(TO_CMAKE_PATH "${CURRENT_INSTALLED_DIR}" CMAKE_INSTALLED_PREFIX)
  foreach(PRL_FILE IN LISTS PRL_FILES)
    file(READ "${PRL_FILE}" _contents)
    string(REPLACE "${CMAKE_LIB_PATH}" "\$\$[QT_INSTALL_LIBS]" _contents
                   "${_contents}")
    string(REPLACE "${CMAKE_INCLUDE_PATH}" "\$\$[QT_INSTALL_HEADERS]" _contents
                   "${_contents}")
    string(REPLACE "${CMAKE_INCLUDE_PATH2}" "\$\$[QT_INSTALL_HEADERS]/../"
                   _contents "${_contents}")
    string(REPLACE "${CMAKE_INSTALLED_PREFIX}" "\$\$[QT_INSTALL_PREFIX]"
                   _contents "${_contents}")
    # Note: This only works without an extra if case since QT_INSTALL_PREFIX is
    # the same for debug and release
    file(WRITE "${PRL_FILE}" "${_contents}")
  endforeach()
endfunction()
