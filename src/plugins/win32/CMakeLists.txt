cmake_minimum_required(VERSION 3.16)

# UTF-8 source
add_compile_options("$<$<AND:$<C_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:C>>:/utf-8>")
add_compile_options("$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/utf-8>")
add_compile_options("$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/Zc:__cplusplus>")

add_subdirectory(tp_stub)
add_subdirectory(ncbind)

add_subdirectory(addFont)
add_subdirectory(binaryStream)
add_subdirectory(csvParser)
#add_subdirectory(fftgraph)
add_subdirectory(KAGParser)
#add_subdirectory(KAGParserEx)
add_subdirectory(stdio)
