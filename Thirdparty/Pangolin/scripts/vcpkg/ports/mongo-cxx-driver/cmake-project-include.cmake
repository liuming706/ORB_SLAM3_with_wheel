if(BSONCXX_POLY_USE_STD AND NOT CMAKE_CXX_STANDARD VERSION_GREATER_EQUAL "17")
  message(WARNING "Enabling C++17 compiler support.")
  set(CMAKE_CXX_STANDARD 17)
endif()
