get_filename_component(
  gettext_tools_dir "${CMAKE_CURRENT_LIST_DIR}/../../tools/gettext/bin"
  ABSOLUTE)
if(CMAKE_HOST_WIN32)
  set(ENV{PATH} "$ENV{PATH};${gettext_tools_dir}")
else()
  set(ENV{PATH} "$ENV{PATH}:${gettext_tools_dir}")
endif()
