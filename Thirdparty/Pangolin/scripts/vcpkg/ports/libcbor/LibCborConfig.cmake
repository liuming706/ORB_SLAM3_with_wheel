# Distributed under the OSI-approved BSD 3-Clause License.

find_path(LIBCBOR_INCLUDE_DIR NAMES cbor.h)

find_library(LIBCBOR_LIBRARY cbor)

find_package_handle_standard_args(LIBCBOR DEFAULT_MSG LIBCBOR_LIBRARY
                                  LIBCBOR_INCLUDE_DIR)

if(LIBCBOR_FOUND)
  set(LIBCBOR_LIBRARIES ${LIBCBOR_LIBRARY})
endif()

mark_as_advanced(LIBCBOR_INCLUDE_DIR LIBCBOR_LIBRARY)
