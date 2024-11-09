cmake_minimum_required(VERSION 3.16)

set(PROJECT_NAME krkrz_all)
set(PROJECT_VERSION 1.01)

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION})

add_subdirectory(src/core ${CMAKE_CURRENT_BINARY_DIR}/core)
add_subdirectory(src/plugins ${CMAKE_CURRENT_BINARY_DIR}/plugins)
