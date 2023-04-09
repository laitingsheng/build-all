include_guard(GLOBAL)

message(STATUS "Using ${DEPENDENCY_VERSION} of MessagePack C++ library.")

ExternalProject_Add("${DEPENDENCY}"
	${EP_BASE_LOCATION_ARGS}
	GIT_REPOSITORY "${GITHUB_PREFIX}msgpack/msgpack-c.git"
	GIT_TAG "cpp-${DEPENDENCY_VERSION}"
	${EP_GIT_ARGS}
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
		"-DMSGPACK_CXX20:BOOL=TRUE"
		"-DMSGPACK_USE_BOOST:BOOL=FALSE"
		"-DMSGPACK_BUILD_DOCS:BOOL=FALSE"
	CONFIGURE_HANDLED_BY_BUILD TRUE
	${EP_WITH_BUILD_EXTRA_ARGS}
	EXCLUDE_FROM_ALL TRUE
)

set(DEPENDENCY_ENABLED TRUE)
