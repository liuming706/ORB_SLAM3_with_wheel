# Try to find the ffmpeg libraries and headers for avcodec avformat swscale
#
# FFMPEG_INCLUDE_DIRS FFMPEG_LIBRARIES FFMPEG_FOUND

# Find header files
find_path(AVCODEC_INCLUDE_DIR libavcodec/avcodec.h /usr/include
          /usr/local/include /opt/local/include /usr/include/x86_64-linux-gnu)
find_path(AVFORMAT_INCLUDE_DIR libavformat/avformat.h /usr/include
          /usr/local/include /opt/local/include /usr/include/x86_64-linux-gnu)
find_path(AVDEVICE_INCLUDE_DIR libavdevice/avdevice.h /usr/include
          /usr/local/include /opt/local/include /usr/include/x86_64-linux-gnu)
find_path(AVUTIL_INCLUDE_DIR libavutil/avutil.h /usr/include /usr/local/include
          /opt/local/include /usr/include/x86_64-linux-gnu)
find_path(SWSCALE_INCLUDE_DIR libswscale/swscale.h /usr/include
          /usr/local/include /opt/local/include /usr/include/x86_64-linux-gnu)

# Find Library files
find_library(AVCODEC_LIBRARY NAMES avcodec PATH /usr/lib /usr/local/lib
                                   /opt/local/lib /usr/lib/x86_64-linux-gnu)
find_library(AVFORMAT_LIBRARY NAMES avformat PATH /usr/lib /usr/local/lib
                                    /opt/local/lib /usr/lib/x86_64-linux-gnu)
find_library(AVDEVICE_LIBRARY NAMES avdevice PATH /usr/lib /usr/local/lib
                                    /opt/local/lib /usr/lib/x86_64-linux-gnu)
find_library(AVUTIL_LIBRARY NAMES avutil PATH /usr/lib /usr/local/lib
                                  /opt/local/lib /usr/lib/x86_64-linux-gnu)
find_library(SWSCALE_LIBRARY NAMES swscale PATH /usr/lib /usr/local/lib
                                   /opt/local/lib /usr/lib/x86_64-linux-gnu)

if(EXISTS "${AVUTIL_INCLUDE_DIR}/libavutil/pixdesc.h")
  set(AVUTIL_HAVE_PIXDESC TRUE)
endif()

if(AVCODEC_INCLUDE_DIR
   AND AVFORMAT_INCLUDE_DIR
   AND AVUTIL_INCLUDE_DIR
   AND AVDEVICE_INCLUDE_DIR
   AND SWSCALE_INCLUDE_DIR
   AND AVCODEC_LIBRARY
   AND AVFORMAT_LIBRARY
   AND AVUTIL_LIBRARY
   AND SWSCALE_LIBRARY
   AND AVDEVICE_LIBRARY
   AND AVUTIL_HAVE_PIXDESC)
  set(FFMPEG_FOUND TRUE)
  set(FFMPEG_LIBRARIES ${AVCODEC_LIBRARY} ${AVFORMAT_LIBRARY} ${AVUTIL_LIBRARY}
                       ${SWSCALE_LIBRARY} ${AVDEVICE_LIBRARY})
  set(FFMPEG_INCLUDE_DIRS
      ${AVCODEC_INCLUDE_DIR} ${AVFORMAT_INCLUDE_DIR} ${AVUTIL_INCLUDE_DIR}
      ${SWSCALE_INCLUDE_DIR} ${AVDEVICE_INCLUDE_DIR})

  include(CheckCXXSourceCompiles)

  set(CMAKE_REQUIRED_INCLUDES ${FFMPEG_INCLUDE_DIRS})

  check_cxx_source_compiles(
    "#include \"${AVCODEC_INCLUDE_DIR}/libavformat/avformat.h\"
      int main() {
        sizeof(AVFormatContext::max_analyze_duration);
      }"
    HAVE_FFMPEG_MAX_ANALYZE_DURATION)
  check_cxx_source_compiles(
    "#include \"${AVCODEC_INCLUDE_DIR}/libavformat/avformat.h\"
      int main() {
        &avformat_alloc_output_context2;
      }"
    HAVE_FFMPEG_AVFORMAT_ALLOC_OUTPUT_CONTEXT2)
  check_cxx_source_compiles(
    "#include \"${AVCODEC_INCLUDE_DIR}/libavutil/pixdesc.h\"
      int main() {
        AVPixelFormat test = AV_PIX_FMT_GRAY8;
      }"
    HAVE_FFMPEG_AVPIXELFORMAT)
endif()

if(FFMPEG_FOUND)
  if(NOT FFMPEG_FIND_QUIETLY)
    message(STATUS "Found FFMPEG: ${FFMPEG_LIBRARIES}")
  endif(NOT FFMPEG_FIND_QUIETLY)
else(FFMPEG_FOUND)
  if(FFMPEG_FIND_REQUIRED)
    message(FATAL_ERROR "Could not find FFMPEG")
  endif(FFMPEG_FIND_REQUIRED)
endif(FFMPEG_FOUND)
