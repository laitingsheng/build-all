cmake_minimum_required(VERSION @CMAKE_MAJOR_VERSION@.@CMAKE_MINOR_VERSION@)

project(giflib
	VERSION "@DEPENDENCY_VERSION@"
	HOMEPAGE_URL "https://giflib.sourceforge.net/"
	LANGUAGES
		C
)

if (MSVC)
	file(READ "${CMAKE_CURRENT_SOURCE_DIR}/gif_hash.h" GIF_HASH_H)
	string(REPLACE "<unistd.h>" "<io.h>" GIF_HASH_H "${GIF_HASH_H}")
	file(GENERATE OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/gif_hash.h" CONTENT "${GIF_HASH_H}" NEWLINE_STYLE LF)
endif ()

add_library(gif STATIC
	"dgif_lib.c"
	"egif_lib.c"
	"gifalloc.c"
	"gif_err.c"
	"gif_font.c"
	"gif_hash.c"
	"openbsd-reallocarray.c"
)
set_property(
	TARGET
		gif
	PROPERTY PUBLIC_HEADER
		"gif_hash.h"
		"gif_lib.h"
)

install(
	TARGETS
		gif
	ARCHIVE
	PUBLIC_HEADER
)
