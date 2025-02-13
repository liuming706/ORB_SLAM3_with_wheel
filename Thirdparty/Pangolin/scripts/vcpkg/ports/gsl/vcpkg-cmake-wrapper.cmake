_find_package(${ARGS})
if(GSL_FOUND AND TARGET GSL::gsl)
  set_property(
    TARGET GSL::gslcblas
    APPEND
    PROPERTY IMPORTED_CONFIGURATIONS Release)
  set_property(
    TARGET GSL::gsl
    APPEND
    PROPERTY IMPORTED_CONFIGURATIONS Release)
  if(EXISTS "${GSL_LIBRARY_DEBUG}" AND EXISTS "${GSL_CBLAS_LIBRARY_DEBUG}")
    set_property(
      TARGET GSL::gsl
      APPEND
      PROPERTY IMPORTED_CONFIGURATIONS Debug)
    set_target_properties(GSL::gsl PROPERTIES IMPORTED_LOCATION_DEBUG
                                              "${GSL_LIBRARY_DEBUG}")
    set_property(
      TARGET GSL::gslcblas
      APPEND
      PROPERTY IMPORTED_CONFIGURATIONS Debug)
    set_target_properties(GSL::gslcblas PROPERTIES IMPORTED_LOCATION_DEBUG
                                                   "${GSL_CBLAS_LIBRARY_DEBUG}")
  endif()
endif()
