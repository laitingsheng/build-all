cmake_minimum_required(VERSION @CMAKE_MAJOR_VERSION@.@CMAKE_MINOR_VERSION@)

project(b2
	VERSION "@DEPENDENCY_VERSION@"
	HOMEPAGE_URL "https://github.com/BLAKE2/libb2"
	LANGUAGES
		C
)

option(USE_SSE "Use SSE implementations." "${UNIX}")

file(TOUCH "${CMAKE_CURRENT_SOURCE_DIR}/config.h")

set(B2_SOURCES
	"blake2sp.c"
	"blake2bp.c"
)
if (USE_SSE)
	list(APPEND B2_SOURCES
		"blake2s.c"
		"blake2b.c"
		"blake2-dispatch.c"
	)
else ()
	list(APPEND B2_SOURCES
		"blake2s-ref.c"
		"blake2b-ref.c"
	)
endif ()

add_library(b2 STATIC ${B2_SOURCES})
set_property(
	TARGET
		b2
	PROPERTY PUBLIC_HEADER
		"blake2.h"
)

install(
	TARGETS
		b2
	ARCHIVE
	PUBLIC_HEADER
)
