if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
  vcpkg_get_windows_sdk(WINDOWS_SDK)

  if(WINDOWS_SDK MATCHES "10.")
    set(LIBGLFILEPATH
        "$ENV{WindowsSdkDir}Lib/${WINDOWS_SDK}/um/${TRIPLET_SYSTEM_ARCH}/OpenGL32.Lib"
    )
    set(LIBGLUFILEPATH
        "$ENV{WindowsSdkDir}Lib/${WINDOWS_SDK}/um/${TRIPLET_SYSTEM_ARCH}/GlU32.Lib"
    )
    set(HEADERSPATH "$ENV{WindowsSdkDir}Include/${WINDOWS_SDK}/um")
  elseif(WINDOWS_SDK MATCHES "8.")
    set(LIBGLFILEPATH
        "$ENV{WindowsSdkDir}Lib/winv6.3/um/${TRIPLET_SYSTEM_ARCH}/OpenGL32.Lib")
    set(LIBGLUFILEPATH
        "$ENV{WindowsSdkDir}Lib/winv6.3/um/${TRIPLET_SYSTEM_ARCH}/GlU32.Lib")
    set(HEADERSPATH "$ENV{WindowsSdkDir}Include/um")
  else()
    message(
      FATAL_ERROR
        "Portfile not yet configured for Windows SDK with version: ${WINDOWS_SDK}"
    )
  endif()

  if(NOT EXISTS "${LIBGLFILEPATH}")
    file(TO_NATIVE_PATH "${LIBGLFILEPATH}" DISPLAY)
    message(
      FATAL_ERROR
        "Cannot find Windows ${WINDOWS_SDK} SDK. File does not exist: ${DISPLAY}"
    )
  endif()

  if(NOT EXISTS "${LIBGLUFILEPATH}")
    file(TO_NATIVE_PATH "${LIBGLUFILEPATH}" DISPLAY)
    message(
      FATAL_ERROR
        "Cannot find Windows ${WINDOWS_SDK} SDK. File does not exist: ${DISPLAY}"
    )
  endif()

  set(INCLUDEGLPATH "${CURRENT_PACKAGES_DIR}/include/gl")
  set(SHAREOPENGLPATH "${CURRENT_PACKAGES_DIR}/share/opengl")
  set(RELEASELIBPATH "${CURRENT_PACKAGES_DIR}/lib")
  set(DEBUGLIBPATH "${CURRENT_PACKAGES_DIR}/debug/lib")
  set(GLGLHPATH "${HEADERSPATH}/gl/GL.h")
  set(GLGLUHPATH "${HEADERSPATH}/gl/GLU.h")

  file(MAKE_DIRECTORY "${INCLUDEGLPATH}" "${SHAREOPENGLPATH}"
       "${RELEASELIBPATH}")
  if(NOT VCPKG_BUILD_TYPE)
    file(MAKE_DIRECTORY "${DEBUGLIBPATH}")
  endif()

  file(COPY "${GLGLHPATH}" "${GLGLUHPATH}" DESTINATION "${INCLUDEGLPATH}")

  if(NOT VCPKG_BUILD_TYPE)
    file(COPY "${LIBGLFILEPATH}" DESTINATION "${DEBUGLIBPATH}")
    file(COPY "${LIBGLUFILEPATH}" DESTINATION "${DEBUGLIBPATH}")
  endif()
  file(COPY "${LIBGLFILEPATH}" DESTINATION "${RELEASELIBPATH}")
  file(COPY "${LIBGLUFILEPATH}" DESTINATION "${RELEASELIBPATH}")

  if(WINDOWS_SDK MATCHES "10.")
    file(
      WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
      "See https://developer.microsoft.com/windows/downloads/windows-10-sdk for the Windows 10 SDK license"
    )
  elseif(WINDOWS_SDK MATCHES "8.")
    file(
      WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
      "See https://developer.microsoft.com/windows/downloads/windows-8-1-sdk for the Windows 8.1 SDK license"
    )
  endif()

  string(REGEX MATCH "^([0-9]+)\\.([0-9]+)\\.([0-9]+)" WINDOWS_SDK_SEMVER
               "${WINDOWS_SDK}")
  configure_file("${CMAKE_CURRENT_LIST_DIR}/opengl.pc.in"
                 "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/opengl.pc" @ONLY)
  configure_file("${CMAKE_CURRENT_LIST_DIR}/glu.pc.in"
                 "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/glu.pc" @ONLY)
  if(NOT VCPKG_BUILD_TYPE)
    configure_file(
      "${CMAKE_CURRENT_LIST_DIR}/opengl.pc.in"
      "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/opengl.pc" @ONLY)
    configure_file("${CMAKE_CURRENT_LIST_DIR}/glu.pc.in"
                   "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/glu.pc" @ONLY)
  endif()

  vcpkg_fixup_pkgconfig()
else()
  set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
endif()
