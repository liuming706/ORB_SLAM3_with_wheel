if(NOT VCPKG_TARGET_IS_WINDOWS)
  message(FATAL_ERROR "qt5-activeqt only support Windows.")
endif()

include(${CURRENT_INSTALLED_DIR}/share/qt5/qt_port_functions.cmake)
qt_submodule_installation()
