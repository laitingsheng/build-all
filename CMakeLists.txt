cmake_minimum_required(VERSION 3.25)

project("build-all"
	VERSION 0.0
	LANGUAGES
		CXX
)

if (DEFINED ENV{CMAKE_CACHE_PREFIX})
	cmake_path(SET EP_PREFIX NORMALIZE "$ENV{CMAKE_CACHE_PREFIX}")
elseif (DEFINED CMAKE_CACHE_PREFIX)
	cmake_path(SET EP_PREFIX NORMALIZE "${CMAKE_CACHE_PREFIX}")
else ()
	cmake_path(SET EP_PREFIX NORMALIZE "${CMAKE_CURRENT_BINARY_DIR}/_deps")
endif ()

if (DEFINED ENV{CMAKE_INSTALL_PREFIX})
	cmake_path(SET EP_INSTALL NORMALIZE "$ENV{CMAKE_INSTALL_PREFIX}")
elseif (DEFINED CMAKE_INSTALL_PREFIX)
	cmake_path(SET EP_INSTALL NORMALIZE "${CMAKE_INSTALL_PREFIX}")
else ()
	cmake_path(SET EP_INSTALL NORMALIZE "${CMAKE_BINARY_DIR}")
endif ()

message(STATUS "ExternalProject prefix is set to ${EP_PREFIX}, installation prefix is set to ${EP_INSTALL}.")

cmake_path(SET NASM_ROOT NORMALIZE "$ENV{NASM_ROOT}")
cmake_path(SET Python_ROOT_DIR NORMALIZE "$ENV{CONDA_PREFIX}")

find_package(PkgConfig GLOBAL BYPASS_PROVIDER)
find_package(Python 3 REQUIRED COMPONENTS Interpreter GLOBAL BYPASS_PROVIDER)

find_program(CMAKE_ASM_NASM_COMPILER "nasm" PATHS "${NASM_ROOT}" REQUIRED NO_DEFAULT_PATH)

include(ExternalProject)

if (MSVC)
	include("fixes/msvc-unistd.cmake" NO_POLICY_SCOPE)
endif ()

include("args.cmake" NO_POLICY_SCOPE)
include("utils.cmake" NO_POLICY_SCOPE)

set(GITHUB_PREFIX "git@github.com:")
set(GITLAB_PREFIX "git@gitlab.com:")

if (MSVC)
	set(MSVC_STATIC_STRINGS "MultiThreaded" "MultiThreadedDebug")
	if (CMAKE_MSVC_RUNTIME_LIBRARY IN_LIST MSVC_STATIC_STRINGS)
		set(MSVCRT_IS_SHARED FALSE)
		set(MSVCRT_IS_STATIC TRUE)
	else ()
		set(MSVCRT_IS_SHARED TRUE)
		set(MSVCRT_IS_STATIC FALSE)
	endif ()
else ()
	set(MSVCRT_IS_SHARED TRUE)
	set(MSVCRT_IS_STATIC TRUE)
endif ()

set(DEPENDENCIES
	"abseil"
	"argparse"
	"brotli"
	"bzip2"
	"ctre"
	"fmt"
	"giflib"
	"jbigkit"
	"jsoncpp"
	"lerc"
	"libdeflate"
	"lz4"
	"mimalloc"
	"nameof"
	"nlohmann_json"
	"xz"
	# "yasm"
	"zlib"
	"zlibwapi"
	"zstd"

	"libjpeg-turbo"
	"libpng"
	"libxlsxwriter"
	"protobuf"
	"spdlog"

	"freetype"
	"harfbuzz"
	"libwebp"

	"libtiff"

	# "openjpeg"

	"opencv"
)
set(ENABLED_DEPENDENCIES)
file(READ "deps/versions.json" DEPENDENCIES_VERSION_JSON)
foreach (DEPENDENCY ${DEPENDENCIES})
	string(JSON DEPENDENCY_VERSION GET "${DEPENDENCIES_VERSION_JSON}" "${DEPENDENCY}")
	set(DEPENDENCY_ENABLED FALSE)
	block (SCOPE_FOR VARIABLES PROPAGATE DEPENDENCY_ENABLED)
		include("deps/${DEPENDENCY}/main.cmake" NO_POLICY_SCOPE)
	endblock ()
	if (DEPENDENCY_ENABLED)
		list(APPEND ENABLED_DEPENDENCIES "${DEPENDENCY}")
	endif ()
endforeach ()
ExternalProject_Add_StepDependencies("freetype" "reconfigure" "harfbuzz-install")

string(JOIN ", " MESSAGE_STRING ${ENABLED_DEPENDENCIES})
message(STATUS "Enabled dependencies: ${MESSAGE_STRING}.")

ExternalProject_Add("build-all-check"
	PREFIX "${CMAKE_CURRENT_BINARY_DIR}/check"
	SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/check"
	DOWNLOAD_COMMAND
	UPDATE_COMMAND
	PATCH_COMMAND
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
	BUILD_COMMAND
	INSTALL_COMMAND
	TEST_COMMAND
	USES_TERMINAL_CONFIGURE TRUE
	DEPENDS
		${DEPENDENCIES}
	EXCLUDE_FROM_ALL TRUE
)

add_executable(dummy "dummy.cpp")
add_dependencies(dummy "build-all-check")
