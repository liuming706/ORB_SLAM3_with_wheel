set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_MULTITHREADED ON)
unset(Boost_USE_STATIC_RUNTIME)
set(Boost_NO_BOOST_CMAKE ON)
unset(Boost_USE_STATIC_RUNTIME CACHE)
if("${CMAKE_VS_PLATFORM_TOOLSET}" STREQUAL "v120")
  set(Boost_COMPILER "-vc120")
else()
  set(Boost_COMPILER "-vc140")
endif()
_find_package(${ARGS})
