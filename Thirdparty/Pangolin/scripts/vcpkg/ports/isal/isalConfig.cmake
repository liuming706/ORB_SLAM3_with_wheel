message(
  WARNING
    "'find_package(isal CONFIG)' is deprecated. Please use 'find_package(unofficial-isal CONFIG)' instead."
)

include(CMakeFindDependencyMacro)
find_dependency(unofficial-isal)
if(NOT TARGET unofficial::isal::isal)
  set(isal_FOUND FALSE)
elseif(TARGET ISAL::isa-l OR TARGET ISAL::isal)
  # done
elseif("@VCPKG_LIBRARY_LINKAGE@" STREQUAL "static")
  add_library(ISAL::isa-l INTERFACE IMPORTED)
  set_target_properties(ISAL::isa-l PROPERTIES INTERFACE_LINK_LIBRARIES
                                               unofficial::isal::isal)
else()
  add_library(ISAL::isal INTERFACE IMPORTED)
  set_target_properties(ISAL::isal PROPERTIES INTERFACE_LINK_LIBRARIES
                                              unofficial::isal::isal)
endif()
