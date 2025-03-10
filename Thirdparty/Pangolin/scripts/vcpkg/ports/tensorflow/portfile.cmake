set(TF_LIB_SUFFIX "")
set(TF_PORT_SUFFIX "")
set(TF_INCLUDE_DIRS "\${TENSORFLOW_INSTALL_PREFIX}/include")
list(APPEND CMAKE_MODULE_PATH
     "${CURRENT_INSTALLED_DIR}/share/tensorflow-common")
include(tensorflow-common)

file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/c_api.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/c_api_experimental.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/c_api_macros.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tensor_interface.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tf_attrtype.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tf_datatype.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tf_file_statistics.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tf_status.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tf_tensor.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/tf_tstring.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/eager/c_api.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c/eager")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/eager/c_api_experimental.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c/eager")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/c/eager/dlpack.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/c/eager")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/core/platform/ctstring.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/core/platform")
file(
  COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bazel-bin/tensorflow/include/tensorflow/core/platform/ctstring_internal.h"
  DESTINATION "${CURRENT_PACKAGES_DIR}/include/tensorflow/core/platform")
