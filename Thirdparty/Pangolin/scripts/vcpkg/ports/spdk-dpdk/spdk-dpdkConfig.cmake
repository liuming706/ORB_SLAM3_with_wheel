function(SET_LIBRARY_TARGET NAMESPACE LIB_NAME DEBUG_LIB_FILE_NAME
         RELEASE_LIB_FILE_NAME INCLUDE_DIR)
  add_library(${NAMESPACE}::${LIB_NAME} STATIC IMPORTED)
  set_target_properties(
    ${NAMESPACE}::${LIB_NAME}
    PROPERTIES IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
               IMPORTED_LOCATION_RELEASE "${RELEASE_LIB_FILE_NAME}"
               IMPORTED_LOCATION_DEBUG "${DEBUG_LIB_FILE_NAME}"
               INTERFACE_INCLUDE_DIRECTORIES "${INCLUDE_DIR}")
  set(${NAMESPACE}_${LIB_NAME}_FOUND 1)
endfunction()

get_filename_component(DPDK_ROOT "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(DPDK_ROOT "${DPDK_ROOT}" PATH)
get_filename_component(DPDK_ROOT "${DPDK_ROOT}" PATH)

set_library_target(
  "SPDK" "dpdk" "${DPDK_ROOT}/debug/lib/spdk/libdpdk.a"
  "${DPDK_ROOT}/lib/spdk/libdpdk.a" "${DPDK_ROOT}/include/spdk-dpdk")

if(CMAKE_BUILD_TYPE STREQUAL Debug)
  link_directories(${DPDK_ROOT}/debug/lib/spdk)
else()
  link_directories(${DPDK_ROOT}/lib/spdk)
endif()

file(GLOB DPDK_LIBS ${DPDK_ROOT}/lib/spdk/librte*.*)
foreach(LIB_FILE_NAME ${DPDK_LIBS})
  get_filename_component(LIB_NAME ${LIB_FILE_NAME} NAME_WE)
  get_filename_component(FULL_LIB_NAME ${LIB_FILE_NAME} NAME)
  string(REPLACE "lib" "" LIB_NAME "${LIB_NAME}")
  set_library_target(
    "SPDK" "${LIB_NAME}" "${DPDK_ROOT}/debug/lib/spdk/${FULL_LIB_NAME}"
    "${DPDK_ROOT}/lib/spdk/${FULL_LIB_NAME}" "${DPDK_ROOT}/include/spdk-dpdk")
endforeach()
