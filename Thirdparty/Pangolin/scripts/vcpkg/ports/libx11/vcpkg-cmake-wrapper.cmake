set(Z_VCPKG_FIRST_X11_SEARCH OFF)
if(NOT X11_FOUND)
  set(Z_VCPKG_FIRST_X11_SEARCH ON)
endif()
_find_package(${ARGS})
if(TARGET X11::X11 AND Z_VCPKG_FIRST_X11_SEARCH)
  target_link_libraries(X11::X11 INTERFACE ${CMAKE_DL_LIBS})
  if(TARGET X11::xcb)
    target_link_libraries(X11::X11 INTERFACE X11::xcb)
  endif()
endif()
if(TARGET X11::xcb AND Z_VCPKG_FIRST_X11_SEARCH)
  if(TARGET X11::Xdmcp)
    set_property(
      TARGET X11::xcb
      APPEND
      PROPERTY INTERFACE_LINK_LIBRARIES X11::Xdmcp)
  endif()
  if(TARGET X11::Xau)
    set_property(
      TARGET X11::xcb
      APPEND
      PROPERTY INTERFACE_LINK_LIBRARIES X11::Xau)
  endif()
endif()
unset(Z_VCPKG_FIRST_X11_SEARCH)
