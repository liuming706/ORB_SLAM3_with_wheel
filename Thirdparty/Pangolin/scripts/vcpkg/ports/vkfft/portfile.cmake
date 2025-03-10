# header-only library
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  DTolm/VkFFT
  REF
  fc981ecc022ae7932d4d906bed3cf9def592ddf5 # v1.2.17
  SHA512
  c2ffae4885fe75778743f4165475026a43ab2ad2df2e02774a2750ad77ad8ceb3c6ff22a5cec56af3913af46eeb48bc09d2e119a54d893daa13af1fd768d9a9f
  HEAD_REF
  master)

file(COPY "${SOURCE_PATH}/vkFFT/"
     DESTINATION "${CURRENT_PACKAGES_DIR}/include/VkFFT")

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
