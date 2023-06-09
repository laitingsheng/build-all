include_guard(GLOBAL)

message(STATUS "Using ${DEPENDENCY_VERSION} of C++ fmt library.")

ExternalProject_Add("${DEPENDENCY}"
	${EP_BASE_LOCATION_ARGS}
	GIT_REPOSITORY "${GITHUB_PREFIX}fmtlib/fmt.git"
	GIT_TAG "${DEPENDENCY_VERSION}"
	${EP_GIT_ARGS}
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
		"-DFMT_DOC:BOOL=FALSE"
		"-DFMT_TEST:BOOL=FALSE"
		"-DFMT_MODULE:BOOL=TRUE"
		"-DFMT_SYSTEM_HEADERS:BOOL=TRUE"
	CONFIGURE_HANDLED_BY_BUILD TRUE
	${EP_WITH_BUILD_EXTRA_ARGS}
	EXCLUDE_FROM_ALL TRUE
)

set(DEPENDENCY_ENABLED TRUE)
