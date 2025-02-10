cmake_minimum_required(VERSION 3.9)
project(ipsec C)

if(SOURCE_PATH)
  set(CMAKE_SOURCE_DIR ${SOURCE_PATH})
endif()

include(ProcessorCount)
ProcessorCount(PROCS)

find_program(NASM nasm)
if(NOT NASM)
  message(FATAL_ERROR "NASM not found")
endif()

find_program(MAKE make)
if(NOT MAKE)
  message(FATAL_ERROR "MAKE not found")
endif()

if(EXEC_ENV STREQUAL "Windows")
  find_program(MAKE nmake)
  if(NOT MAKE)
    message(FATAL_ERROR "nmake not found")
  endif()
endif()

set(MAKE_FLAGS)

if(EXEC_ENV STREQUAL "Windows")
  list(APPEND MAKE_FLAGS /f win_x64.mak)
endif()

if(CMAKE_BUILD_TYPE STREQUAL Debug)
  list(APPEND MAKE_FLAGS DEBUG=y)
endif()

if(NOT BUILD_SHARED_LIBS)
  list(APPEND MAKE_FLAGS SHARED=n)
endif()

message(STATUS "${MAKE_FLAGS}")
add_custom_target(
  ipsec-mb ALL
  COMMAND ${MAKE} -j ${MAKE_FLAGS}
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/
  # VERBATIM
)

set(LIB_PATH ${CMAKE_SOURCE_DIR}/)
if(BUILD_SHARED_LIBS)
  string(APPEND LIB_PATH libIPSec_MB.so)
else()
  string(APPEND LIB_PATH libIPSec_MB.a)
endif()
install(FILES ${LIB_PATH}
        DESTINATION ${CMAKE_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/lib/)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/include
        DESTINATION ${CMAKE_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/)
