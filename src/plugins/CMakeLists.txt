cmake_minimum_required(VERSION 3.16)

# UTF-8 source
add_compile_options("$<$<AND:$<C_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:C>>:/utf-8>")
add_compile_options("$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/utf-8>")
add_compile_options("$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/Zc:__cplusplus>")

# すべてのプラグインでMT(d)を強制する
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

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
# layerExSave
lineParser
memfile
#minizip
#psdfile
saveStruct
scriptsEx
shrinkCopy
sigcheck
systemEx
varfile
)


if (WIN32)
list(APPEND PLUGINS
fstat
menu
msgreceiver
stdio
# resourceRW
win32dialog
windowEx
httprequest
shellExecute
)
if (!WIN64)
list(APPEND PLUGINS 
httpserv
process
win32ole
windowExProgress
tftSave
messenger
)
endif()
endif()

# 特殊プラグイン
# STEAMプラグインはSDKパスが環境変数で提供された場合のみビルド
if(DEFINED ENV{STEAMWORKS_SDK})
list(APPEND PLUGINS 
	steam
)
endif()

if (WIN64)
set(PLUGIN_DIR "plugins64")
else()
set(PLUGIN_DIR "plugins")
endif()

foreach(PLUGIN ${PLUGINS})
    add_subdirectory(${PLUGIN})
    install(TARGETS ${PLUGIN} 
        LIBRARY DESTINATION ${PLUGIN_DIR}
        RUNTIME DESTINATION ${PLUGIN_DIR}
    )
endforeach()

