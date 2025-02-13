_find_package(${ARGS})
find_package(ZLIB REQUIRED)
find_package(PNG REQUIRED)
find_package(JPEG REQUIRED)
find_package(BZip2 REQUIRED)
if(TARGET Irrlicht::Irrlicht)
  set_property(
    TARGET Irrlicht::Irrlicht
    APPEND
    PROPERTY INTERFACE_LINK_LIBRARIES ZLIB::ZLIB PNG::PNG JPEG::JPEG
             BZip2::BZip2)
endif()
if(IRRLICHT_LIBRARIES)
  list(APPEND IRRLICHT_LIBRARIES ${ZLIB_LIBRARIES} ${PNG_LIBRARIES}
       ${JPEG_LIBRARIES} ${BZIP2_LIBRARIES})
endif()
