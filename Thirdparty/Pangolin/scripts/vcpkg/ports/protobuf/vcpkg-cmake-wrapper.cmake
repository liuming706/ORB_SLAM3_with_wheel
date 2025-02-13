if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.3)
  cmake_policy(PUSH)
  cmake_policy(SET CMP0057 NEW)
  if(NOT "CONFIG" IN_LIST ARGS AND NOT "NO_MODULE" IN_LIST ARGS)
    if("@VCPKG_LIBRARY_LINKAGE@" STREQUAL "static")
      set(Protobuf_USE_STATIC_LIBS ON)
    else()
      set(Protobuf_USE_STATIC_LIBS OFF)
    endif()
  endif()
  cmake_policy(POP)
endif()

find_program(
  Protobuf_PROTOC_EXECUTABLE
  NAMES protoc
  PATHS "${CMAKE_CURRENT_LIST_DIR}/../../../@HOST_TRIPLET@/tools/protobuf"
  NO_DEFAULT_PATH)

_find_package(${ARGS})
