set(VCPKG_POLICY_EMPTY_PACKAGE enabled)

if(CMAKE_HOST_WIN32)
  foreach(
    PROG
    GO
    JOM
    NASM
    PERL
    YASM
    GIT
    PYTHON3
    PYTHON2
    RUBY
    7Z
    NUGET
    FLEX
    BISON
    GPERF
    GASPREPROCESSOR
    DARK
    SCONS
    SWIG
    DOXYGEN
    ARIA2
    PKGCONFIG)
    vcpkg_find_acquire_program(${PROG})
    foreach(SUBPROG IN LISTS ${PROG})
      if(NOT EXISTS "${SUBPROG}")
        message(FATAL_ERROR "Program ${SUBPROG} did not exist.")
      endif()
    endforeach()
  endforeach()
endif()

foreach(PROG GN NINJA MESON BAZEL)
  vcpkg_find_acquire_program(${PROG})
  foreach(SUBPROG IN LISTS ${PROG})
    if(NOT EXISTS "${SUBPROG}")
      message(FATAL_ERROR "Program ${SUBPROG} did not exist.")
    endif()
  endforeach()
endforeach()
