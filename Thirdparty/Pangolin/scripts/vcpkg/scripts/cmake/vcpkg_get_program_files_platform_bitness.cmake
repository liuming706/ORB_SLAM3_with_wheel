function(vcpkg_get_program_files_platform_bitness out_var)
  if(DEFINED ENV{ProgramW6432})
    set("${out_var}"
        "$ENV{ProgramW6432}"
        PARENT_SCOPE)
  else()
    set("${out_var}"
        "$ENV{PROGRAMFILES}"
        PARENT_SCOPE)
  endif()
endfunction()
