include("${CMAKE_CURRENT_LIST_DIR}/unofficial-brotli-targets.cmake")
foreach(target IN ITEMS brotlicommon brotlidec brotlienc)
  if(TARGET unofficial::brotli::${target}
     AND NOT TARGET unofficial::brotli::${target}-static)
    _add_library(unofficial::brotli::${target}-static INTERFACE IMPORTED)
    set_target_properties(
      unofficial::brotli::${target}-static
      PROPERTIES INTERFACE_LINK_LIBRARIES "unofficial::brotli::${target}")
  endif()
  if(NOT TARGET unofficial::brotli::${target}
     AND TARGET unofficial::brotli::${target}-static)
    _add_library(unofficial::brotli::${target} INTERFACE IMPORTED)
    set_target_properties(
      unofficial::brotli::${target}
      PROPERTIES INTERFACE_LINK_LIBRARIES
                 "unofficial::brotli::${target}-static")
  endif()
endforeach()
