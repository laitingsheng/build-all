cmake_minimum_required(VERSION @CMAKE_MAJOR_VERSION@.@CMAKE_MINOR_VERSION@)

project(giflib
	VERSION "@DEPENDENCY_VERSION@"
	HOMEPAGE_URL "https://giflib.sourceforge.net/"
	LANGUAGES
		C
)

add_library(gif STATIC
	"dgif_lib.c"
	"egif_lib.c"
	"gifalloc.c"
	"gif_err.c"
	"gif_font.c"
	"gif_hash.c"
	"openbsd-reallocarray.c"
)
if (MSVC)
	target_include_directories(gif SYSTEM
		PRIVATE
			"${CMAKE_INSTALL_PREFIX}/include"
	)
endif ()
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
