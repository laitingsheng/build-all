include_guard(GLOBAL)

message(STATUS "Using ${DEPENDENCY_VERSION} of LZ4 library.")

ExternalProject_Add("${DEPENDENCY}"
	${EP_BASE_LOCATION_ARGS}
	GIT_REPOSITORY "${GITHUB_PREFIX}lz4/lz4.git"
	GIT_TAG "v${DEPENDENCY_VERSION}"
	${EP_GIT_ARGS}
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
		"-DBUILD_SHARED_LIBS:BOOL=FALSE"
		"-DBUILD_STATIC_LIBS:BOOL=TRUE"
	SOURCE_SUBDIR "build/cmake"
	CONFIGURE_HANDLED_BY_BUILD TRUE
	${EP_WITH_BUILD_EXTRA_ARGS}
	EXCLUDE_FROM_ALL TRUE
)

set(DEPENDENCY_ENABLED TRUE)
