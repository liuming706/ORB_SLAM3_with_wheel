# Every update requires an update of these hashes and the version within the
# control file of each of the 32 ports. So it is probably better to have a
# central location for these hashes and let the ports update via a script
set(QT_MAJOR_MINOR_VER 5.15)
set(QT_PATCH_VER 7)
set(QT_UPDATE_VERSION 0) # Switch to update qt and not build qt. Creates a file
                         # cmake/qt_new_hashes.cmake in qt5-base with the new
                         # hashes.

set(QT_PORT_LIST
    base
    3d
    activeqt
    charts
    connectivity
    datavis3d
    declarative
    gamepad
    graphicaleffects
    imageformats
    location
    macextras
    mqtt
    multimedia
    networkauth
    purchasing
    quickcontrols
    quickcontrols2
    remoteobjects
    script
    scxml
    sensors
    serialport
    speech
    svg
    tools
    virtualkeyboard
    webchannel
    websockets
    webview
    winextras
    xmlpatterns
    doc
    x11extras
    androidextras
    translations
    serialbus
    webengine
    webglplugin
    wayland)

set(QT_HASH_qt5-3d
    557afedecc8b8ea30f47ac17b1cfc2192ff46b79f2633c22e0d28ee65413e1e9f3145dea074f76300ea5e455a78e1980db071de106facb8c0c12f16ecf06ea4a
)
set(QT_HASH_qt5-activeqt
    4ab40d88f134dc04ba3d0df2464241978ccf497221b24fec55a93c54482dd5613bcf16570543f64fe629a79efe00e7df015675ccace9bcf1d86223929ff92932
)
set(QT_HASH_qt5-androidextras
    fa2b11354aa1059c50d6731d4e57d892b3147e80c95fe16568e45ccddfd19580f8084c80cff49ee94c0f57331983ee4f993c5970e4c3999e67978c80d197c116
)
set(QT_HASH_qt5-base
    316de71fba1d5dd91354155dcd0f77e1ce2a798f8296a8699a795ea5e86ad10b6e233299775a92e23328290f3e041240585947e89ee7bd39eb464c5f0ffec343
)
set(QT_HASH_qt5-charts
    fd0c9a282edb60a08b72e8453ccd316de70da34111a85369239f54f00808d08b9aca77f73c6ecfe3f33a6678c9c74eb2310c21a9522d6dec6ce940a8e030c688
)
set(QT_HASH_qt5-connectivity
    22a8a9cc0214f0b6560d487553c65183496ca7738642663e64973368c852cf053b3c4b39ba80569dd2b7e308d955dd2de7d3a8ef5ab1cba3a2fd3859de35af5f
)
set(QT_HASH_qt5-datavis3d
    df07e33031dfd8759c49a3b1116f61242e3d1c731d52deb26745e3d575b8b429fd8806122445f03de6f24b7f65fc170d71338c42ff524093b846a3b00d32908c
)
set(QT_HASH_qt5-declarative
    909721a7c756ad3f55fa30b539ddd7f459449edc599883a4e04acbe6f1cecaf44b3a5f2b3b17adb83adaf8cd3e1e5e7e09829b30b0df3dacb1e203892b996508
)
set(QT_HASH_qt5-doc
    b9783d539a1ee05d8f069664a2f764d2ad6bf6e93adc1027e4f931631e2eb9033e07f75a84359e27f8be0b8d661b127b20797ef4d554bffe8bc7f139c24b4623
)
set(QT_HASH_qt5-gamepad
    e7269096dbbb3238d7009f5a5e686bce02987a81cef4282d7aa52848916cec67c73c4dfb16cf48a9f46fa9f3c509a789d5622bdf9823df299f1a8c7c67d5b27f
)
set(QT_HASH_qt5-graphicaleffects
    c733253e6c0ee6049dffbcd2ce4fdb5095e7c0eb87dae5d7eb3b4c2ee8ff5329c99e5ff8949bf4613b00aefdb34a9869eb7099e23e8e45ce721d30cc6eba2207
)
set(QT_HASH_qt5-imageformats
    6e899aa975856eb2b9b113dbcf75692fedfbb31559ecf09dd128886d77dcde68848403144e1f0e73b9b9f909a46e082f24a29db2fcc5bc5810bb93a88ad7150d
)
set(QT_HASH_qt5-location
    fc4579b14f7f4836ef550d80b867c2655f52da34b0637dce4d83b10f2f7a836530a8f2a6b0f1a41c38e5e391c5d8e2431818e9813fd9d597f67704fcfbfb2f7e
)
set(QT_HASH_qt5-macextras
    62c46302b392bf5dc5da175a5ed1e26a03195c32fe5873e927ccf31ca34cd1f4ab7544148e34b27d064eed090cba496761d61caa8bea4ac863a9a3a6425ba182
)
set(QT_HASH_qt5-mqtt
    827a6cde96a99fcd23f22b1bd98af54d6395ab1dd9fe4332fc0c1a186152e29f835e44fb3d9d867b1935795b23463ed17b0b96ad189a635911f6a19a55378b38
)
set(QT_HASH_qt5-multimedia
    f6f5b5d3522aa99b52b720d34fedbff935cf0ac0371576845d3f6a01d0db6d1fd19b17353e2abf2e7916b3d3a3f1c741b0aa7ea810cfc827c0dc3affe0e93150
)
set(QT_HASH_qt5-networkauth
    43c4f9dd0847504de3db9e75b669d70853377721230fd0dd3d958bdf2e730e4f5a19c1946eb2f658bc978814b48d977693dea1280ea8050dbbe05bc79a481b60
)
set(QT_HASH_qt5-purchasing
    336c5405389b91493ddad96b514ec627ceb941573f46d728ecfc45a852fd4ecfdbbdda4beaef9601182f704754e2e0ed263e0c2225a2b4f86947be7edce5051c
)
set(QT_HASH_qt5-quickcontrols
    111b8ce5e6fa95b885b70bdd35e761c33e061cbc09879368aee9ee63dc4c3188bb5fac2c4f3022ac935879ee91ef0d0ab2b5da2e5792d07c3a798472a490f654
)
set(QT_HASH_qt5-quickcontrols2
    f49e330593b23ab9e84874a7cee1583df9355dd68d7c25e57fba080997b860b86f9003190e5d9a5b393efcb143fd20866daf2c8088a769e3094d6cf9607febd5
)
set(QT_HASH_qt5-remoteobjects
    abc4c8b4fe5e7383e5b4160ff79f8c1630e148e307386dbf7d7ee88c7b1b307a6c961c9a87ee9152e6267583e004d9b23c9b96458a3edcb42f247e9cde37937d
)
set(QT_HASH_qt5-script
    448ce8f8e7f669ee7eadff7abbfa2e9a80ed56cc7c4916391e385728bc96d406b8d98d7c2916c09cd2c0fa2c834b16854960eb96ed49cc81f05c183104141c7c
)
set(QT_HASH_qt5-scxml
    ff3fd21b0bba3f092d236d875559d4e992180a2d9e8ffd8a628a5c82518329c99587eeddd90fdd10c340d1bc4c9077a4d439be1a3d7aa0dfe3f1a557ee934bd3
)
set(QT_HASH_qt5-sensors
    dca0b149f086b0a949809bdc78f1551b27036608802a04f274d7bec38e5eb53ac2c3d78cda83f6d447aa6fc9490bdc19135e925c429cd9ea7290dae27bf00fcd
)
set(QT_HASH_qt5-serialbus
    b67a409e48c28e91dc53bbf29716209ab37b75e0e54d54002c4eec10aa2209252cf5fb37b3c6b1004ec800a4dcd5313b6beda46167ed64dbabe6bd5e1b9be4b0
)
set(QT_HASH_qt5-serialport
    80d17988676d0c8985406a13ad97d4b9ed1c00af8c84f6fa550f5a1057fbe0988993aa6ccc9cceb058104ecd9526314d33f4efab27b62f45981456c4f052cccf
)
set(QT_HASH_qt5-speech
    3db8edbf16366bcb155aa254483f059f0d6c6af769ff4e2bb87061c7c352fdbb30b63e4644e287a116292fa4f5f6f6c148b99fc9d39ded14e337f014a6aa66ea
)
set(QT_HASH_qt5-svg
    56f3e4518be16f8f1a189e3fe4f3c93905546690e1be52d16e3d0f87000f692119b41cf3fd5bf1584d80bc69855726c9fd16f6dd5b601b57bf60c1afe9420116
)
set(QT_HASH_qt5-tools
    40176727d8c8430171483fd5815c1f84b8fc4d1a1b26b943c817e9a14cfe2d155c76039593f68f45b7e9276189968f3b37e1b17fd99adda7664582bf30a3935a
)
set(QT_HASH_qt5-translations
    0a0db22f4035b2f8421c8d0fcc4587e2511c883f90624efae56a7481eb0f9ebde0fd4e678ff95e628ed30335a59a38b47e524e7c3dee9f7751fea7003953b4a3
)
set(QT_HASH_qt5-virtualkeyboard
    c9dba2ea41850693217617b881e6ff85765e328cf37bf020012f4852c768266713961376706722385cbb39167be62df34f7531c189d9638d9024c9865fd339a1
)
set(QT_HASH_qt5-wayland
    a004a82ec2b4f132d597ae3c82b4079671ecdfeed09c455073e552197da2b9f921c85bef2b40be76e87e61d5ec1e7ab39ed232be26b27d9aed6e938c659965a3
)
set(QT_HASH_qt5-webchannel
    fe846db6c345bf13fe28b3541df36b6ad397d57fd382a9b2d3685d01f2c6da0cf51173b23416eebd9ab52d82e7af4c45b0305d50cd63d79adee061b5a63efd8f
)
set(QT_HASH_qt5-webengine
    26174a9986411ea0cb2d6a919f5163db2cf0ff4ad1bf66f4498ef0eda1f9d8eea112d145f8273c666338a963d66cfbf1e06d2c2752254ef1669f3f76cd68d696
)
set(QT_HASH_qt5-webglplugin
    c5a105a77e30099f7cb9a0519333007092391ed3d4366b7a4846d7847c6252510c696c6ca0a4ab60d7c9916e8511f8129668e4445b6d27f823d4ad6f0e51b927
)
set(QT_HASH_qt5-websockets
    b7e48e8cedfb71c33193fae5c6039b2ca042d4acdcf77beb52703be1e39f86c4ca37f3b9182c50c280cedb587eec4980f35387aa77e8454d901fd775c9f88dd5
)
set(QT_HASH_qt5-webview
    7f1befd10507efc010e4f1c459a0971aa32f288202e6151815885deb89462d20ac6182e4976cecc47e39ac8e7eb545e50c5eeac963b57fc66dab5a84e5ab587b
)
set(QT_HASH_qt5-winextras
    7fc47d856445e97c022af4d6ff138e2846cf7f27bb87c67f9db0db008d7f25c49ca58f08bc8154464f272b298fc923fcacbb5b8f795038d692ae39592e97f832
)
set(QT_HASH_qt5-x11extras
    e368a1e14d4007edf642de7efb027f783cd816247c01629a68fddcb0e5c3ae1a412ea66e00a021c82de5f22e7afb1883bf7aaca03067c38346a92a26ae61ae06
)
set(QT_HASH_qt5-xmlpatterns
    28b506dedde18a05861e6cf2d8f530436da873ab5ece5db164baab4deffac2a3bbff6e6a5052da795cb9f2abd2ce55256e2d68127aa6f11d4611137dafa85fa4
)

if(QT_UPDATE_VERSION)
  message(STATUS "Running Qt in automatic version port update mode!")
  set(_VCPKG_INTERNAL_NO_HASH_CHECK 1)
  if("${PORT}" MATCHES "qt5-base")
    function(update_qt_version_in_manifest _port_name)
      set(_current_control "${VCPKG_ROOT_DIR}/ports/${_port_name}/vcpkg.json")
      file(READ ${_current_control} _control_contents)
      # message(STATUS "Before: \n${_control_contents}")
      string(
        REGEX
        REPLACE "\"version.*\": \"[0-9]+\.[0-9]+\.[0-9]+\",\n"
                "\"version\": \"${QT_MAJOR_MINOR_VER}.${QT_PATCH_VER}\",\n"
                _control_contents "${_control_contents}")
      string(REGEX REPLACE "\n  \"port-version\": [0-9]+," "" _control_contents
                           "${_control_contents}")
      # message(STATUS "After: \n${_control_contents}")
      file(WRITE ${_current_control} "${_control_contents}")
      configure_file("${_current_control}" "${_current_control}" @ONLY
                     NEWLINE_STYLE LF)
    endfunction()

    update_qt_version_in_manifest("qt5")
    foreach(_current_qt_port_basename ${QT_PORT_LIST})
      update_qt_version_in_manifest("qt5-${_current_qt_port_basename}")
    endforeach()
  endif()
endif()
