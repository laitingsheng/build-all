cmake_minimum_required(VERSION @CMAKE_MAJOR_VERSION@.@CMAKE_MINOR_VERSION@)

project(jbig
	VERSION "@DEPENDENCY_VERSION@"
	HOMEPAGE_URL "https://www.cl.cam.ac.uk/~mgk25/jbigkit"
	LANGUAGES
		C
)

add_library(jbig STATIC
	"jbig.c"
	"jbig_ar.c"
	"jbig85.c"
)
set_property(
	TARGET
		jbig
	PROPERTY PUBLIC_HEADER
		"jbig.h"
		"jbig_ar.h"
		"jbig85.h"
)

install(
	TARGETS
		jbig
	ARCHIVE
	PUBLIC_HEADER
)
