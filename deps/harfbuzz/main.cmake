include_guard(GLOBAL)

message(STATUS "Using ${DEPENDENCY_VERSION} of ${DEPENDENCY}.")

ExternalProject_Add("${DEPENDENCY}"
	${EP_BASE_LOCATION_ARGS}
	GIT_REPOSITORY "${GITHUB_PREFIX}harfbuzz/harfbuzz.git"
	GIT_TAG "${DEPENDENCY_VERSION}"
	${EP_GIT_ARGS}
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
		"-DBUILD_SHARED_LIBS:BOOL=FALSE"
		"-DHB_HAVE_FREETYPE:BOOL=TRUE"
		"-DHB_HAVE_CORETEXT:BOOL=TRUE"
		"-DHB_HAVE_UNISCRIBE:BOOL=TRUE"
		"-DHB_HAVE_GDI:BOOL=TRUE"
		"-DHB_HAVE_DIRECTWRITE:BOOL=TRUE"
	CONFIGURE_HANDLED_BY_BUILD TRUE
	${EP_WITH_BUILD_EXTRA_ARGS}
	DEPENDS
		"freetype-install"
	EXCLUDE_FROM_ALL TRUE
	STEP_TARGETS
		"install"
)

set(DEPENDENCY_ENABLED TRUE)
