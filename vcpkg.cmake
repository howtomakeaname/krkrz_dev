
# find vcpkg's toolchains

find_file(VCPKG_TRIPLET_FILE ${VCPKG_TARGET_TRIPLET}.cmake $ENV{VCPKG_ROOT}/triplets $ENV{VCPKG_ROOT}/triplets/community)
if (VCPKG_TRIPLET_FILE) 
	message("load triplet file:${VCPKG_TRIPLET_FILE}")
	include(${VCPKG_TRIPLET_FILE})
	set(SCRIPTS $ENV{VCPKG_ROOT}/scripts)
    if(NOT VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
        if(NOT DEFINED VCPKG_CMAKE_SYSTEM_NAME OR _TARGETTING_UWP)
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/windows.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/linux.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Android")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/android.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/osx.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "iOS")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/ios.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/freebsd.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "MinGW")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/mingw.cmake")
        elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "NX")
            set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${SCRIPTS}/toolchains/nx.cmake")
        endif()
    endif()
else()
	message(WARNING "triplet:${VCPKG_TARGET_TRIPLET} file is not found")
endif()

message("toolchain:${VCPKG_CHAINLOAD_TOOLCHAIN_FILE}")

set(CMAKE_TOOLCHAIN_FILE $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)

if (${CMAKE_BUILD_TYPE} MATCHES Release)
    add_compile_definitions(
        MASTER
    )
endif()
