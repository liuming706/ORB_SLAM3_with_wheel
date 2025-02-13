vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  andrew-gresyk/HFSM2
  REF
  1_10_1
  SHA512
  49ae09a3e4052c7a70390510d128d4d0a41f3c2b6bb9cf2c0b36d272ca1a2524c1d2b544e4c36655681255ce6a5e2f3f90f8c4e9957e8c49e49a62927134a718
  HEAD_REF
  master)

# Install include directory
file(INSTALL "${SOURCE_PATH}/include" DESTINATION "${CURRENT_PACKAGES_DIR}")

# Handle copyright
file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)

# Copy usage file
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
