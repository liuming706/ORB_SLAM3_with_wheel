include(FindPackageHandleStandardArgs)

find_path(
  NUMA_ROOT_DIR
  NAMES include/numa.h
  PATHS ENV NUMA_ROOT
  DOC "NUMA library root directory")

find_path(
  NUMA_INCLUDE_DIR
  NAMES numa.h
  HINTS ${NUMA_ROOT_DIR}
  PATH_SUFFIXES include
  DOC "NUMA include directory")

find_library(
  NUMA_LIBRARY
  NAMES numa
  HINTS ${NUMA_ROOT_DIR}
  DOC "NUMA library file")

if(NUMA_LIBRARY)
  get_filename_component(NUMA_LIBRARY_DIR ${NUMA_LIBRARY} PATH)
  mark_as_advanced(NUMA_INCLUDE_DIR NUMA_LIBRARY_DIR NUMA_LIBRARY)
  find_package_handle_standard_args(
    NUMA REQUIRED_VARS NUMA_ROOT_DIR NUMA_INCLUDE_DIR NUMA_LIBRARY)
else()
  set(NUMA_FOUND FALSE)
  message(
    FATAL_ERROR
      "Numa library not found.\nTry: 'sudo yum install numactl numactl-devel' (or sudo apt-get install libnuma1 libnuma-dev)"
  )
endif()
