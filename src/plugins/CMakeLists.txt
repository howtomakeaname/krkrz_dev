cmake_minimum_required(VERSION 3.16)

if(WIN32 AND (CMAKE_SIZEOF_VOID_P EQUAL 8))
set(WIN64 1)
endif()

# 基本プラグイン
add_subdirectory(tp_stub)
add_subdirectory(ncbind)

set(PLUGINS
#KAGParserEx
addFont
binaryStream
csvParser
fpslimit
getSample
json
layerExAreaAverage
layerExBTOA
layerExDraw
layerExImage
layerExLongExposure
layerExRaster
layerExSave
lineParser
minizip
saveStruct
scriptsEx
shrinkCopy
#sigcheck
systemEx
tftSave
)


if (WIN32)
list(APPEND PLUGINS

# IStream/GlobalAllocをつかってるので現時点でWIN専用。要改修
memfile
#psdfile
varfile

fstat
menu
msgreceiver
stdio
#resourceRW
win32dialog
windowEx
httprequest
shellExecute
#httpserv
process
messenger
windowExProgress
#win32ole
)
endif()

# 特殊プラグイン
# STEAMプラグインはSDKパスが環境変数で提供された場合のみビルド
if(DEFINED ENV{STEAMWORKS_SDK})
list(APPEND PLUGINS 
#	steam
)
endif()

if (WIN64)
set(PLUGIN_DIR "plugin64")
else()
set(PLUGIN_DIR "plugin")
endif()

foreach(PLUGIN ${PLUGINS})
    add_subdirectory(${PLUGIN})
    install(TARGETS ${PLUGIN} 
        LIBRARY DESTINATION ${PLUGIN_DIR}
        RUNTIME DESTINATION ${PLUGIN_DIR}
    )
endforeach()

