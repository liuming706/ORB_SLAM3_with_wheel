# Declare a named external dependency for download with vcpkg_from_git, and
# validate against upstream's DEPS.
function(declare_external_from_git name)
  cmake_parse_arguments(PARSE_ARGV 1 arg "" "URL;REF;LICENSE_FILE" "")
  if(NOT arg_URL
     OR NOT arg_REF
     OR NOT arg_LICENSE_FILE)
    message(FATAL_ERROR "Arguments URL, REF and LICENSE_FILE are required.")
  endif()
  set(actual "${arg_URL}@${arg_REF}")
  file(STRINGS "${SOURCE_PATH}/DEPS" upstream
       REGEX "\"third_party/externals/${name}\"")
  string(FIND "${upstream}" "${arg_URL}@${arg_REF}" pos)
  if(pos STREQUAL "-1")
    string(REGEX REPLACE "^[^:]*:  *" "" upstream "${upstream}")
    message(
      WARNING
        "Dependency ${name} diverges from upstream. Upstream: ${upstream} Actual: \"${actual}\""
    )
  endif()
  set(skia_external_license_${name}
      "${arg_LICENSE_FILE}"
      PARENT_SCOPE)
  list(REMOVE_ITEM ARGN "LICENSE_FILE" "${arg_LICENSE_FILE}")
  set(skia_external_git_${name}
      "${ARGN}"
      PARENT_SCOPE)
endfunction()

# Declare a named external dependencies to be resolved via pkgconfig.
function(declare_external_from_pkgconfig name)
  set(skia_external_pkgconfig_${name}
      "${ARGN}"
      PARENT_SCOPE)
endfunction()

# Download and integrate named external dependencies. Downlods must be handled
# before vcpkg in order to support --only-downloads mode.
function(get_externals)
  set(licenses_dir "${SOURCE_PATH}/third_party_licenses")
  file(REMOVE_RECURSE "${licenses_dir}")
  file(MAKE_DIRECTORY "${licenses_dir}")

  list(REMOVE_DUPLICATES ARGN)
  set(from_git "")
  set(from_pkgconfig "")
  foreach(name IN LISTS ARGN)
    if(DEFINED "skia_external_git_${name}")
      list(APPEND from_git "${name}")
    elseif(DEFINED "skia_external_pkgconfig_${name}")
      list(APPEND from_pkgconfig "${name}")
    else()
      message(FATAL_ERROR "Unknown external dependency '${name}'")
    endif()
  endforeach()
  foreach(name IN LISTS from_git)
    set(dir "third_party/externals/${name}")
    if(EXISTS "${SOURCE_PATH}/${dir}")
      message(STATUS "Using existing ${dir}")
      continue()
    endif()
    message(STATUS "Creating ${dir}")
    file(MAKE_DIRECTORY "${SOURCE_PATH}/third_party/externals")
    vcpkg_from_git(OUT_SOURCE_PATH staging_dir ${skia_external_git_${name}})
    file(RENAME "${staging_dir}" "${SOURCE_PATH}/${dir}")

    set(license_file "${SOURCE_PATH}/${dir}/${skia_external_license_${name}}")
    cmake_path(GET license_file FILENAME filename)
    file(COPY_FILE "${license_file}" "${licenses_dir}/## ${name} ${filename}")
  endforeach()
  foreach(name IN LISTS from_pkgconfig)
    third_party_from_pkgconfig("${name}" ${skia_external_pkgconfig_${name}})
  endforeach()
endfunction()

# Setup a third-party dependency from pkg-config data
function(third_party_from_pkgconfig gn_group)
  cmake_parse_arguments(PARSE_ARGV 1 arg "" "PATH" "DEFINES;MODULES")
  if(NOT arg_PATH)
    set(arg_PATH "third_party/${gn_group}")
  endif()
  if(NOT arg_MODULES)
    set(arg_MODULES "${gn_group}")
  endif()
  if(arg_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
  endif()
  x_vcpkg_pkgconfig_get_modules(PREFIX PC_${module} MODULES ${arg_MODULES}
                                CFLAGS LIBS)
  foreach(config IN ITEMS DEBUG RELEASE)
    separate_arguments(cflags UNIX_COMMAND "${PC_${module}_CFLAGS_${config}}")
    set(defines "${cflags}")
    list(FILTER defines INCLUDE REGEX "^-D")
    list(TRANSFORM defines REPLACE "^-D" "")
    list(APPEND defines ${arg_DEFINES})
    set(include_dirs "${cflags}")
    list(FILTER include_dirs INCLUDE REGEX "^-I")
    list(TRANSFORM include_dirs REPLACE "^-I" "")
    separate_arguments(libs UNIX_COMMAND "${PC_${module}_LIBS_${config}}")
    set(lib_dirs "${libs}")
    list(FILTER lib_dirs INCLUDE REGEX "^-L")
    list(TRANSFORM lib_dirs REPLACE "^-L" "")
    # Passing link libraries via ldflags, cf. third-party.gn.in
    set(ldflags "${libs}")
    list(FILTER ldflags INCLUDE REGEX "^-l")
    if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
      list(TRANSFORM ldflags REPLACE "^-l" "")
      list(TRANSFORM ldflags APPEND ".lib")
    endif()
    set(GN_OUT_${config} "")
    foreach(item IN ITEMS defines include_dirs lib_dirs ldflags)
      set("gn_${item}_${config}" "")
      if(NOT "${${item}}" STREQUAL "")
        list(JOIN ${item} [[", "]] list)
        set("gn_${item}_${config}" "\"${list}\"")
      endif()
    endforeach()
  endforeach()
  configure_file("${CMAKE_CURRENT_LIST_DIR}/third-party.gn.in"
                 "${SOURCE_PATH}/${arg_PATH}/BUILD.gn" @ONLY)
endfunction()

# Turn a space separated string into a gn list: "a b c" -> ["a","b","c"]
function(string_to_gn_list out_var input)
  separate_arguments(list UNIX_COMMAND "${input}")
  if(NOT list STREQUAL "")
    list(JOIN list [[","]] temp)
    set(list "\"${temp}\"")
  endif()
  set("${out_var}"
      "[${list}]"
      PARENT_SCOPE)
endfunction()

# Remove all empty directories.
function(auto_clean dir)
  file(GLOB entries "${dir}/*")
  file(
    GLOB files
    LIST_DIRECTORIES false
    "${dir}/*")
  foreach(entry IN LISTS entries)
    if(entry IN_LIST files)
      continue()
    endif()
    file(GLOB_RECURSE children "${entry}/*")
    if(children)
      auto_clean("${entry}")
    else()
      file(REMOVE_RECURSE "${entry}")
    endif()
  endforeach()
endfunction()

function(list_from_json out_var json) # <path>
  vcpkg_list(SET list)
  string(
    JSON
    array
    ERROR_VARIABLE
    error
    GET
    "${json}"
    ${ARGN})
  if(NOT error)
    string(JSON len ERROR_VARIABLE error LENGTH "${array}")
    if(NOT error AND NOT len STREQUAL "0")
      math(EXPR last "${len} - 1")
      foreach(i RANGE "${last}")
        string(JSON item GET "${array}" "${i}")
        vcpkg_list(APPEND list "${item}")
      endforeach()
    endif()
  endif()
  set("${out_var}"
      "${list}"
      PARENT_SCOPE)
endfunction()

# Put the target's SK_<...> definitions in out_var
function(get_definitions out_var desc_json target)
  list_from_json(output "${desc_json}" "${target}" "defines")
  list(FILTER output INCLUDE REGEX "^SK_")
  set("${out_var}"
      "${output}"
      PARENT_SCOPE)
endfunction()

# Put the target's link libraries in out_var
function(get_link_libs out_var desc_json target)
  # From ldflags, we only want lib names or filepaths (cf.
  # declare_external_from_pkgconfig)
  list_from_json(ldflags "${desc_json}" "${target}" "ldflags")
  if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
    list(FILTER ldflags INCLUDE REGEX "[.]lib\$")
  else()
    list(FILTER ldflags INCLUDE REGEX "^-l|^/")
  endif()
  list(TRANSFORM ldflags REPLACE "^-l" "")
  list_from_json(libs "${desc_json}" "${target}" "libs")
  vcpkg_list(SET frameworks)
  if(VCPKG_TARGET_IS_OSX OR VCPKG_TARGET_IS_IOS)
    list_from_json(frameworks "${desc_json}" "${target}" "frameworks")
  endif()
  vcpkg_list(SET output)
  foreach(lib IN LISTS frameworks ldflags libs)
    string(REPLACE "${CURRENT_INSTALLED_DIR}" [[${vcpkg_root}]] lib "${lib}")
    string(REPLACE "${CURRENT_PACKAGES_DIR}" [[${vcpkg_root}]] lib "${lib}")
    if(NOT lib MATCHES "^-L")
      vcpkg_list(REMOVE_ITEM output "${lib}")
    endif()
    vcpkg_list(APPEND output "${lib}")
  endforeach()
  set("${out_var}"
      "${output}"
      PARENT_SCOPE)
endfunction()
