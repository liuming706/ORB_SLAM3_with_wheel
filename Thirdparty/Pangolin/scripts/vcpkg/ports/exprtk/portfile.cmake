vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  ArashPartow/exprtk
  REF
  806C519C91FD08BA4FA19380DBF3F6E42DE9E2D1
  SHA512
  A323CCAF161FD0087FD8208D1B24C2A3FD422F8875E29B22AE70E6DD2F10F396F6BF1AD36D3FFDC10D32314AE8F83749974301A349BE0F27733292BCF5193640
  HEAD_REF
  master)

file(COPY ${SOURCE_PATH}/exprtk.hpp DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/copyright
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
