function(vcpkg_fail_port_install)
  message(
    "${Z_VCPKG_BACKCOMPAT_MESSAGE_LEVEL}"
    "vcpkg_fail_port_install has been removed and all values should be moved by adding `supports` field to manifest file or directly adding `${PORT}:${FAILED_TRIPLET}=fail` to _scripts/ci.baseline.txt_.\nPlease remove `vcpkg_fail_port_install(...)`.\n"
  )

  set(multi_args "ON_TARGET;ON_ARCH;ON_CRT_LINKAGE;ON_LIBRARY_LINKAGE")
  cmake_parse_arguments(PARSE_ARGV 0 "arg" "ALWAYS" "MESSAGE" "${multi_args}")
  if(DEFINED arg_UNPARSED_ARGUMENTS)
    message(
      FATAL_ERROR
        "vcpkg_fail_port_install was passed extra arguments: ${arg_UNPARSED_ARGUMENTS}"
    )
  endif()

  if(arg_ALWAYS)
    vcpkg_list(SET extra_args)
    foreach(arg IN LISTS multi_args)
      if(DEFINED "arg_${arg}")
        vcpkg_list(APPEND extra_args "${arg}" "${arg_${arg}}")
      endif()
    endforeach()
    if(NOT "${extra_args}" STREQUAL "")
      message(
        WARNING
          "vcpkg_fail_port_install set to fail both unconditionally and conditionally on ${extra_args}. This is likely to be an error."
      )
    endif()
    if(NOT DEFINED arg_MESSAGE)
      message(
        FATAL_ERROR
          "vcpkg_fail_port_install(ALWAYS) was called without a specific MESSAGE."
      )
    endif()

    message(FATAL_ERROR "${arg_MESSAGE}")
  endif()

  if(DEFINED arg_MESSAGE)
    string(APPEND arg_MESSAGE "\n")
  else()
    set(arg_MESSAGE "")
  endif()

  set(fail_port OFF)
  # Target fail check
  if(DEFINED arg_ON_TARGET)
    foreach(target IN LISTS arg_ON_TARGET)
      string(TOUPPER "${target}" target_upper)
      if(VCPKG_TARGET_IS_${target_upper})
        set(fail_port ON)
        string(APPEND arg_MESSAGE
               "Target '${target}' not supported by ${PORT}!\n")
      endif()
    endforeach()
  endif()

  # Architecture fail check
  if(DEFINED arg_ON_ARCH)
    foreach(arch IN LISTS arg_ON_ARCH)
      if(VCPKG_TARGET_ARCHITECTURE STREQUAL arch)
        set(fail_port ON)
        string(APPEND arg_MESSAGE
               "Architecture '${arch}' not supported by ${PORT}!\n")
      endif()
    endforeach()
  endif()

  # CRT linkage fail check
  if(DEFINED arg_ON_CRT_LINKAGE)
    foreach(crt_linkage IN LISTS arg_ON_CRT_LINKAGE)
      if(VCPKG_CRT_LINKAGE STREQUAL crt_linkage)
        set(fail_port ON)
        string(APPEND arg_MESSAGE
               "CRT linkage '${VCPKG_CRT_LINKAGE}' not supported by ${PORT}!\n")
      endif()
    endforeach()
  endif()

  # Library linkage fail check
  if(DEFINED arg_ON_LIBRARY_LINKAGE)
    foreach(library_linkage IN LISTS arg_ON_LIBRARY_LINKAGE)
      if(VCPKG_LIBRARY_LINKAGE STREQUAL library_linkage)
        set(fail_port ON)
        string(
          APPEND
          arg_MESSAGE
          "Library linkage '${VCPKG_LIBRARY_LINKAGE}' not supported by ${PORT}!\n"
        )
      endif()
    endforeach()
  endif()

  if(fail_port)
    message(FATAL_ERROR "${arg_MESSAGE}")
  endif()
endfunction()
