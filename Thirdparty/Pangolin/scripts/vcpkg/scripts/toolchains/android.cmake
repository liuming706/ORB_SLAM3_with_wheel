set(ANDROID_CPP_FEATURES
    "rtti exceptions"
    CACHE STRING "")
set(CMAKE_SYSTEM_NAME
    Android
    CACHE STRING "")
set(ANDROID_TOOLCHAIN
    clang
    CACHE STRING "")
set(ANDROID_NATIVE_API_LEVEL
    ${CMAKE_SYSTEM_VERSION}
    CACHE STRING "")
if(CMAKE_SYSTEM_VERSION MATCHES "^[0-9]+$")
  set(ANDROID_PLATFORM
      android-${CMAKE_SYSTEM_VERSION}
      CACHE STRING "")
else()
  set(ANDROID_PLATFORM
      ${CMAKE_SYSTEM_VERSION}
      CACHE STRING "")
endif()
set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION
    clang
    CACHE STRING "")

if(VCPKG_TARGET_TRIPLET MATCHES "arm64-android")
  set(ANDROID_ABI
      arm64-v8a
      CACHE STRING "")
elseif(VCPKG_TARGET_TRIPLET MATCHES "armv6-android")
  set(ANDROID_ABI
      armeabi
      CACHE STRING "")
  set(ANDROID_ARM_MODE
      arm
      CACHE STRING "")
elseif(VCPKG_TARGET_TRIPLET MATCHES "arm-neon-android")
  set(ANDROID_ABI
      armeabi-v7a
      CACHE STRING "")
  set(ANDROID_ARM_NEON
      ON
      CACHE BOOL "")
elseif(VCPKG_TARGET_TRIPLET MATCHES "arm-android")
  set(ANDROID_ABI
      armeabi-v7a
      CACHE STRING "")
  set(ANDROID_ARM_NEON
      OFF
      CACHE BOOL "")
elseif(VCPKG_TARGET_TRIPLET MATCHES "x64-android")
  set(ANDROID_ABI
      x86_64
      CACHE STRING "")
elseif(VCPKG_TARGET_TRIPLET MATCHES "x86-android")
  set(ANDROID_ABI
      x86
      CACHE STRING "")
else()
  message(FATAL_ERROR "Unknown ABI for target triplet ${VCPKG_TARGET_TRIPLET}")
endif()

if(VCPKG_CRT_LINKAGE STREQUAL "dynamic")
  set(ANDROID_STL
      c++_shared
      CACHE STRING "")
else()
  set(ANDROID_STL
      c++_static
      CACHE STRING "")
endif()

if(DEFINED ENV{ANDROID_NDK_HOME})
  set(ANDROID_NDK_HOME $ENV{ANDROID_NDK_HOME})
else()
  set(ANDROID_NDK_HOME
      "$ENV{ProgramData}/Microsoft/AndroidNDK64/android-ndk-r13b/")
  if(NOT EXISTS "${ANDROID_NDK_HOME}")
    # Use Xamarin default installation folder
    set(ANDROID_NDK_HOME
        "$ENV{ProgramFiles\(x86\)}/Android/android-sdk/ndk-bundle")
  endif()
endif()

if(NOT EXISTS "${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake")
  message(
    FATAL_ERROR "Could not find android ndk. Searched at ${ANDROID_NDK_HOME}")
endif()

include("${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake")

if(NOT _VCPKG_ANDROID_TOOLCHAIN)
  set(_VCPKG_ANDROID_TOOLCHAIN 1)
  get_property(_CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)
  if(NOT _CMAKE_IN_TRY_COMPILE)
    string(APPEND CMAKE_C_FLAGS " -fPIC ${VCPKG_C_FLAGS} ")
    string(APPEND CMAKE_CXX_FLAGS " -fPIC ${VCPKG_CXX_FLAGS} ")
    string(APPEND CMAKE_C_FLAGS_DEBUG " ${VCPKG_C_FLAGS_DEBUG} ")
    string(APPEND CMAKE_CXX_FLAGS_DEBUG " ${VCPKG_CXX_FLAGS_DEBUG} ")
    string(APPEND CMAKE_C_FLAGS_RELEASE " ${VCPKG_C_FLAGS_RELEASE} ")
    string(APPEND CMAKE_CXX_FLAGS_RELEASE " ${VCPKG_CXX_FLAGS_RELEASE} ")

    string(APPEND CMAKE_SHARED_LINKER_FLAGS " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_DEBUG
           " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_DEBUG " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_RELEASE
           " ${VCPKG_LINKER_FLAGS_RELEASE} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_RELEASE
           " ${VCPKG_LINKER_FLAGS_RELEASE} ")
  endif()
endif()
