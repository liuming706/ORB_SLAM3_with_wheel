vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

if(VCPKG_TARGET_IS_UWP)
  message(FATAL_ERROR "Sciter only supports Windows Desktop")
endif()

set(VCPKG_POLICY_DLLS_WITHOUT_LIBS enabled)

set(SCITER_REVISION 52bfe183983118c884294c864ee7b3d0dd199de6)
set(SCITER_SHA
    d31ef2a07525bf1c91b9f36ee434db6227bead732f5779cb4ee28ab6d92957bfb3d4656a960d3c47e64f3efc207f78be64853a56b1e1a14f56fd3c829b022155
)

if(VCPKG_TARGET_ARCHITECTURE STREQUAL x64)
  set(SCITER_ARCH x64)
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL x86)
  set(SCITER_ARCH x32)
else()
  message(FATAL_ERROR "Sciter only supports x86/x64")
endif()

# check out the
# `https://github.com/c-smile/sciter-js-sdk/archive/${SCITER_REVISION}.tar.gz`
# hash checksum can be obtained with `curl -L -o tmp.tgz ${URL} && vcpkg hash
# tmp.tgz`
vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  c-smile/sciter-js-sdk
  REF
  ${SCITER_REVISION}
  SHA512
  ${SCITER_SHA})

# install include directory
file(
  INSTALL ${SOURCE_PATH}/include/
  DESTINATION ${CURRENT_PACKAGES_DIR}/include/sciter-js
  FILES_MATCHING
  PATTERN "*.cpp"
  PATTERN "*.mm"
  PATTERN "*.h"
  PATTERN "*.hpp")

set(SCITER_SHARE "${CURRENT_PACKAGES_DIR}/share/sciter-js")
set(SCITER_TOOLS ${CURRENT_PACKAGES_DIR}/tools/sciter-js)
set(TOOL_PERMS
    FILE_PERMISSIONS
    OWNER_READ
    OWNER_WRITE
    OWNER_EXECUTE
    GROUP_READ
    GROUP_EXECUTE
    WORLD_READ
    WORLD_EXECUTE)

# license
file(COPY ${SOURCE_PATH}/logfile.md DESTINATION ${SCITER_SHARE})
file(
  INSTALL ${SOURCE_PATH}/LICENSE
  DESTINATION ${SCITER_SHARE}
  RENAME copyright)

# tools
if(VCPKG_TARGET_IS_LINUX AND VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
  set(SCITER_BIN ${SOURCE_PATH}/bin/linux/x64)

  file(
    INSTALL ${SOURCE_PATH}/bin/linux/packfolder
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})
  file(
    INSTALL ${SOURCE_PATH}/bin/linux/qjs
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})
  file(
    INSTALL ${SOURCE_PATH}/bin/linux/qjsc
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})

  file(
    INSTALL ${SCITER_BIN}/usciter
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})
  file(
    INSTALL ${SCITER_BIN}/inspector
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})
  file(INSTALL ${SCITER_BIN}/libsciter-gtk.so DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/sciter-sqlite.so DESTINATION ${SCITER_TOOLS})

  if("windowless" IN_LIST FEATURES)
    set(SCITER_BIN ${SOURCE_PATH}/bin.lite/linux/x64)
  endif()

  file(INSTALL ${SCITER_BIN}/libsciter-gtk.so
       DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(INSTALL ${SCITER_BIN}/libsciter-gtk.so
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

  file(INSTALL ${SCITER_BIN}/sciter-sqlite.so
       DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(INSTALL ${SCITER_BIN}/sciter-sqlite.so
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

elseif(VCPKG_TARGET_IS_OSX)
  set(SCITER_BIN ${SOURCE_PATH}/bin/macosx)

  file(
    INSTALL ${SCITER_BIN}/packfolder
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})
  file(
    INSTALL ${SCITER_BIN}/qjs
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})
  file(
    INSTALL ${SCITER_BIN}/qjsc
    DESTINATION ${SCITER_TOOLS}
    ${TOOL_PERMS})

  file(INSTALL ${SCITER_BIN}/inspector.app DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/usciterjs.app DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/libsciter.dylib DESTINATION ${SCITER_TOOLS})

  execute_process(
    COMMAND sh -c "chmod +x usciterjs.app/Contents/MacOS/usciterjs"
    WORKING_DIRECTORY ${SCITER_TOOLS})
  execute_process(
    COMMAND sh -c "chmod +x inspector.app/Contents/MacOS/inspector"
    WORKING_DIRECTORY ${SCITER_TOOLS})

  file(INSTALL ${SCITER_BIN}/libsciter.dylib
       DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(INSTALL ${SCITER_BIN}/libsciter.dylib
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

elseif(VCPKG_TARGET_IS_WINDOWS)
  set(SCITER_BIN ${SOURCE_PATH}/bin/windows/${SCITER_ARCH})
  set(SCITER_BIN32 ${SOURCE_PATH}/bin/windows/x32)

  file(INSTALL ${SOURCE_PATH}/bin/windows/packfolder.exe
       DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SOURCE_PATH}/bin/windows/qjs.exe DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SOURCE_PATH}/bin/windows/qjsc.exe DESTINATION ${SCITER_TOOLS})

  file(INSTALL ${SCITER_BIN}/scapp.exe DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/usciter.exe DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/inspector.exe DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/window-mixin.exe DESTINATION ${SCITER_TOOLS})
  file(INSTALL ${SCITER_BIN}/sciter.dll DESTINATION ${SCITER_TOOLS})

  if("windowless" IN_LIST FEATURES)
    set(SCITER_BIN ${SOURCE_PATH}/bin.lite/windows/${SCITER_ARCH})
  endif()

  file(INSTALL ${SCITER_BIN}/sciter.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
  file(INSTALL ${SCITER_BIN}/sciter.dll
       DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

  message(WARNING "Sciter requires manual deployment of the correct DLL files.")

endif()
