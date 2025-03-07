if(NOT _VCPKG_IOS_TOOLCHAIN)
  set(_VCPKG_IOS_TOOLCHAIN 1)

  # Set the CMAKE_SYSTEM_NAME for try_compile calls.
  set(CMAKE_SYSTEM_NAME
      iOS
      CACHE STRING "")

  macro(_vcpkg_setup_ios_arch arch)
    unset(_vcpkg_ios_system_processor)
    unset(_vcpkg_ios_sysroot)
    unset(_vcpkg_ios_target_architecture)

    if("${arch}" STREQUAL "arm64")
      set(_vcpkg_ios_system_processor "aarch64")
      set(_vcpkg_ios_target_architecture "arm64")
    elseif("${arch}" STREQUAL "arm")
      set(_vcpkg_ios_system_processor "arm")
      set(_vcpkg_ios_target_architecture "armv7")
    elseif("${arch}" STREQUAL "x64")
      set(_vcpkg_ios_system_processor "x86_64")
      set(_vcpkg_ios_sysroot "iphonesimulator")
      set(_vcpkg_ios_target_architecture "x86_64")
    elseif("${arch}" STREQUAL "x86")
      set(_vcpkg_ios_system_processor "i386")
      set(_vcpkg_ios_sysroot "iphonesimulator")
      set(_vcpkg_ios_target_architecture "i386")
    else()
      message(
        FATAL_ERROR
          "Unknown VCPKG_TARGET_ARCHITECTURE value provided for triplet ${VCPKG_TARGET_TRIPLET}: ${arch}"
      )
    endif()
  endmacro()

  _vcpkg_setup_ios_arch("${VCPKG_TARGET_ARCHITECTURE}")
  if(_vcpkg_ios_system_processor AND NOT CMAKE_SYSTEM_PROCESSOR)
    set(CMAKE_SYSTEM_PROCESSOR ${_vcpkg_ios_system_processor})
  endif()

  # If VCPKG_OSX_ARCHITECTURES or VCPKG_OSX_SYSROOT is set in the triplet, they
  # will take priority, so the following will be no-ops.
  set(CMAKE_OSX_ARCHITECTURES
      "${_vcpkg_ios_target_architecture}"
      CACHE STRING "Build architectures for iOS")
  if(_vcpkg_ios_sysroot)
    set(CMAKE_OSX_SYSROOT
        ${_vcpkg_ios_sysroot}
        CACHE STRING "iOS sysroot")
  endif()

  get_property(_CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE)
  if(NOT _CMAKE_IN_TRY_COMPILE)
    string(APPEND CMAKE_C_FLAGS_INIT " -fPIC ${VCPKG_C_FLAGS} ")
    string(APPEND CMAKE_CXX_FLAGS_INIT " -fPIC ${VCPKG_CXX_FLAGS} ")
    string(APPEND CMAKE_C_FLAGS_DEBUG_INIT " ${VCPKG_C_FLAGS_DEBUG} ")
    string(APPEND CMAKE_CXX_FLAGS_DEBUG_INIT " ${VCPKG_CXX_FLAGS_DEBUG} ")
    string(APPEND CMAKE_C_FLAGS_RELEASE_INIT " ${VCPKG_C_FLAGS_RELEASE} ")
    string(APPEND CMAKE_CXX_FLAGS_RELEASE_INIT " ${VCPKG_CXX_FLAGS_RELEASE} ")

    string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_DEBUG_INIT
           " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_DEBUG_INIT
           " ${VCPKG_LINKER_FLAGS_DEBUG} ")
    string(APPEND CMAKE_SHARED_LINKER_FLAGS_RELEASE_INIT
           " ${VCPKG_LINKER_FLAGS_RELEASE} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_RELEASE_INIT
           " ${VCPKG_LINKER_FLAGS_RELEASE} ")
  endif()
endif()
