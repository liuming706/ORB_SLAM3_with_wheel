vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  rioki/rsig
  REF
  v0.1.1
  SHA512
  1b14a543d55086da5cb678b1654267b4e7c54c7b6ef1d3b65a19ee72c362b62ecdf456c2bea8f19aaec1bee8c30b32d5d79e7ed19725d7fe26204874d063175c
)

file(INSTALL ${SOURCE_PATH}/rsig/rsig.h
     DESTINATION ${CURRENT_PACKAGES_DIR}/include/rsig)

file(COPY "${CURRENT_PORT_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
configure_file(${SOURCE_PATH}/LICENSE.txt
               ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
