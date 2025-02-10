find_path(RDMA_INCLUDE_DIR rdma/rdma_cma.h /usr/include /usr/include/linux
          /usr/local/include)

find_library(
  RDMA_LIBRARY
  NAMES rdmacm
  PATHS /usr/lib
        /usr/local/lib
        /usr/lib64
        /usr/local/lib64
        /lib/i386-linux-gnu
        /lib/x86_64-linux-gnu
        /usr/lib/x86_64-linux-gnu)

include(FindPackageHandleStandardArgs)
if(APPLE)
  find_package_handle_standard_args(RDMA DEFAULT_MSG RDMA_INCLUDE_DIR)
else()
  find_package_handle_standard_args(RDMA DEFAULT_MSG RDMA_LIBRARY
                                    RDMA_INCLUDE_DIR)
endif()

mark_as_advanced(RDMA_INCLUDE_DIR RDMA_LIBRARY)

if(NOT RDMA_LIBRARY)
  set(RDMA_FOUND FALSE)
  message(
    FATAL_ERROR
      "RDMA library not found.\nTry: 'sudo yum install librdmacm-devel librdmacm' (or sudo apt-get install librdmacm-dev librdmacm1)"
  )
endif()
