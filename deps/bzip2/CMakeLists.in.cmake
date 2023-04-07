cmake_minimum_required(VERSION @CMAKE_MAJOR_VERSION@.@CMAKE_MINOR_VERSION@)

project(bzip2
	VERSION "@DEPENDENCY_VERSION@"
	HOMEPAGE_URL "https://sourceware.org/bzip2"
	LANGUAGES
		C
)

add_library(bz2 STATIC
	"blocksort.c"
	"huffman.c"
	"crctable.c"
	"randtable.c"
	"compress.c"
	"decompress.c"
	"bzlib.c"
)
target_compile_definitions(bz2
	PRIVATE
		_FILE_OFFSET_BITS=64
)
set_property(
	TARGET
		bz2
	PROPERTY PUBLIC_HEADER
		"bzlib.h"
)

install(
	TARGETS
		bz2
	ARCHIVE
	PUBLIC_HEADER
)
