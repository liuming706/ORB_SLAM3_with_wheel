vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  OlafvdSpek/ctemplate
  REF
  1c397b63e62dc6547054f4711c27918aedce4c2d # accessed on 2020-09-14
  SHA512
  9691393cbb89972e95dba3cb802d0a0379f8f45cddc696e4ce223eb94887b3be46a9d999cac161069261ef63ba26fbdc392c53c3f977e1a7ae51768caa7739ea
  HEAD_REF
  master)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_find_acquire_program(PYTHON3)

vcpkg_configure_cmake(
  SOURCE_PATH
  ${SOURCE_PATH}
  PREFER_NINJA
  OPTIONS
  -DPYTHON_EXECUTABLE=${PYTHON3}
  OPTIONS_DEBUG
  -DDISABLE_INSTALL_HEADERS=ON)

vcpkg_install_cmake()

file(
  INSTALL ${SOURCE_PATH}/COPYING
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/ctemplate
  RENAME copyright)

vcpkg_copy_pdbs()
