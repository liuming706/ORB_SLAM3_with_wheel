# Lua can be compiled as either C or C++. Default configuration is C, set
# COMPILE_AS_CPP to ON to use C++. See
# http://stackoverflow.com/questions/13560945/c-and-c-library-using-longjmp for
# why would you want to do that. Primary differences: - Exceptions will be used
# instead of setjmp/longjmp - The name mangling for functions will be C++
# instead of C. - This is a source-incompatible change because extern "C" is
# chosen by the including application. - The lua.hpp header will not be
# available.

project(lua)

cmake_minimum_required(VERSION 3.18)

# Build Libraries
file(GLOB HDR_LIBLUA "${CMAKE_SOURCE_DIR}/src/*.h")
# For luac.c
list(REMOVE_ITEM HDR_LIBLUA "${CMAKE_SOURCE_DIR}/src/lopnames.h")

file(GLOB SRC_LIBLUA "${CMAKE_SOURCE_DIR}/src/*.c")
# Executables luac and luai
list(REMOVE_ITEM SRC_LIBLUA "${CMAKE_SOURCE_DIR}/src/luac.c"
     "${CMAKE_SOURCE_DIR}/src/lua.c")

if(WIN32)
  # remove warnings
  add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

if(UNIX)
  add_definitions(-DLUA_USE_POSIX)
endif()

# C library
set(CMAKE_C_STANDARD 99)
set(SRC_LIBLUAC ${SRC_LIBLUA})
add_library(lua ${SRC_LIBLUAC} ${HDR_LIBLUA})
target_include_directories(
  lua
  PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/src>
  PUBLIC $<INSTALL_INTERFACE:include>)
set_property(TARGET lua PROPERTY POSITION_INDEPENDENT_CODE ON)
set_source_files_properties(${SRC_LIBLUAC} PROPERTIES LANGUAGE C)

if(BUILD_SHARED_LIBS AND WIN32)
  target_compile_definitions(lua PUBLIC -DLUA_BUILD_AS_DLL)
endif()

if(UNIX)
  if(APPLE)
    target_compile_definitions(lua PUBLIC -DLUA_USE_DLOPEN)
  else()
    find_library(LIB_DLOPEN NAMES dl)
    if(LIB_DLOPEN)
      target_compile_definitions(lua PUBLIC -DLUA_USE_DLOPEN)
      target_link_libraries(lua ${CMAKE_DL_LIBS})
    endif()
    find_library(LIB_MATH NAMES m)
    if(LIB_MATH)
      target_link_libraries(lua m)
    endif()
  endif()
endif()

install(
  TARGETS lua
  EXPORT unofficial-lua-config
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)

install(EXPORT unofficial-lua-config DESTINATION share/unofficial-lua)

# CXX library
if(COMPILE_AS_CPP)
  add_subdirectory(cpp)
endif()

if(INSTALL_TOOLS)
  # compiler uses non-exported APIs, so must include sources directly.
  add_executable(luac ${CMAKE_SOURCE_DIR}/src/luac.c ${SRC_LIBLUA}
                      ${CMAKE_SOURCE_DIR}/src/lopnames.h)
  add_executable(luai ${CMAKE_SOURCE_DIR}/src/lua.c) # interpreter

  target_include_directories(luac PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src)
  target_link_libraries(luai PRIVATE lua)
  set_target_properties(luai PROPERTIES OUTPUT_NAME lua PDB_NAME luai)
  if(UNIX)
    if(CMAKE_SYSTEM_NAME STREQUAL FreeBSD)
      set(_LIB_READLINE_NAME edit)
    else()
      set(_LIB_READLINE_NAME readline)
    endif()
    find_library(LIB_READLINE NAMES ${_LIB_READLINE_NAME})
    if(LIB_READLINE)
      target_compile_definitions(luai PUBLIC -DLUA_USE_READLINE)
      target_link_libraries(luai ${LIB_READLINE})
      if(_LIB_READLINE_NAME STREQUAL edit)
        target_include_directories(luai PUBLIC /usr/include/edit)
      endif()
    endif()
  endif()
  install(TARGETS luai luac RUNTIME DESTINATION tools/lua)
endif()

if(NOT SKIP_INSTALL_HEADERS)
  install(FILES src/lualib.h src/lua.h src/luaconf.h src/lauxlib.h
          DESTINATION include)
  # If using C++, don't install extern "C" wrapper.
  if(NOT COMPILE_AS_CPP)
    install(FILES src/lua.hpp DESTINATION include)
  endif()
endif()
