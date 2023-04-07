cmake_minimum_required(VERSION @CMAKE_MAJOR_VERSION@.@CMAKE_MINOR_VERSION@)

project(zlibwapi VERSION "@DEPENDENCY_VERSION@")

set(LIBRARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/dll@LIBRARY_DIR_SUFFIX@")

install(FILES
	"${LIBRARY_DIR}/zlibwapi.dll"
	TYPE BIN
)
install(FILES
	"${LIBRARY_DIR}/zlibwapi.lib"
	TYPE LIB
)
