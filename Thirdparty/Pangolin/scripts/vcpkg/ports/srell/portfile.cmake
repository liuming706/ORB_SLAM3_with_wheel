set(VERSION 3_010)

vcpkg_download_distfile(
  ARCHIVE
  URLS
  "https://www.akenotsuki.com/misc/srell/srell${VERSION}.zip"
  FILENAME
  "srell${VERSION}.zip"
  SHA512
  5F2762A98E1B68C3A4FA79051AE2CBEFD23CEDF1CE833FA1EB812D3F1112734018AF36AA9D9A50E2DC40C87A7FAAF46AF0B8F4161481994DC5E19F44301E867D
)

vcpkg_extract_source_archive(SOURCE_PATH ARCHIVE "${ARCHIVE}"
                             NO_REMOVE_ONE_LEVEL)

file(INSTALL "${SOURCE_PATH}/srell.hpp" "${SOURCE_PATH}/srell_ucfdata2.hpp"
     "${SOURCE_PATH}/srell_updata.hpp"
     DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(
  INSTALL "${SOURCE_PATH}/license.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright)
