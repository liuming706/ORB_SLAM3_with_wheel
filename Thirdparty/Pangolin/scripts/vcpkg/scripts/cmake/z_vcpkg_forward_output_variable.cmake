macro(z_vcpkg_forward_output_variable ptr_to_parent_var var_to_forward)
  if("${ARGC}" GREATER "2")
    message(
      FATAL_ERROR
        "z_vcpkg_forward_output_variable was passed extra arguments: ${ARGN}")
  endif()
  if(DEFINED "${ptr_to_parent_var}")
    if(DEFINED "${var_to_forward}")
      set("${${ptr_to_parent_var}}"
          "${${var_to_forward}}"
          PARENT_SCOPE)
    else()
      unset("${${ptr_to_parent_var}}" PARENT_SCOPE)
    endif()
  endif()
endmacro()
