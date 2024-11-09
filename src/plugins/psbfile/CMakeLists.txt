cmake_minimum_required(VERSION 3.16)

set(PROJECT_NAME psbfile)
set(PROJECT_VERSION 1.01)

set(PSB_FOLDER psb)
set(NCBIND_FOLDER ../ncbind)
set(TPSTUB_FOLDER ..)

if ( MSVC )
	# UTF-8 source
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /utf-8")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /utf-8")
	set(CMAKE_RC_FLAGS "")
endif()

set(LIBNAME ${PROJECT_NAME})

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION})

add_library( ${LIBNAME} SHARED
    ${NCBIND_FOLDER}/ncbind.cpp
    ${TPSTUB_FOLDER}/tp_stub.cpp
    ${PSB_FOLDER}/psb.cpp
    main.cpp
)

#set_target_properties(${LIBNAME} PROPERTIES 
#  DEBUG_POSTFIX "_d")

target_include_directories(${LIBNAME} PRIVATE 
  ${PSB_FOLDER}
  ${NCBIND_FOLDER}
  ${TPSTUB_FOLDER}
)

target_compile_definitions(${LIBNAME} PRIVATE
)
