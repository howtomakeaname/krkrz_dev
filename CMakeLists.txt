cmake_minimum_required(VERSION 3.16)

# UTF-8 source
add_compile_options("$<$<AND:$<C_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:C>>:/utf-8>")
add_compile_options("$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/utf-8>")
add_compile_options("$<$<AND:$<CXX_COMPILER_ID:MSVC>,$<COMPILE_LANGUAGE:CXX>>:/Zc:__cplusplus>")

set(PROJECT_NAME krkrz)
set(PROJECT_VERSION 1.01)

# vcpkg を利用して構築する
include(vcpkg.cmake)

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION})

add_subdirectory(src/core ${CMAKE_CURRENT_BINARY_DIR}/core)
add_subdirectory(src/plugins/win32 ${CMAKE_CURRENT_BINARY_DIR}/plugins/win32)
