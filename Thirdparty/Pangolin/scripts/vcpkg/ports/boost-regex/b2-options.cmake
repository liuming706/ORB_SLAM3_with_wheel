if("icu" IN_LIST FEATURES)
  set(B2_REQUIREMENTS
      "<library>/user-config//icuuc <library>/user-config//icudt <library>/user-config//icuin <define>BOOST_HAS_ICU=1"
  )
  if(APPLE)
    list(APPEND B2_OPTIONS cxxstd=11)
  endif()
else()
  list(APPEND B2_OPTIONS --disable-icu)
endif()
