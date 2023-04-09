include_guard(GLOBAL)

message(STATUS "Using ${DEPENDENCY_VERSION} of YASM assembler.")

ExternalProject_Add("${DEPENDENCY}"
	${EP_BASE_LOCATION_ARGS}
	GIT_REPOSITORY "${GITHUB_PREFIX}yasm/yasm.git"
	GIT_TAG "v${DEPENDENCY_VERSION}"
	${EP_GIT_ARGS}
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
	CONFIGURE_HANDLED_BY_BUILD TRUE
	${EP_WITH_BUILD_EXTRA_ARGS}
	EXCLUDE_FROM_ALL TRUE
)

set(DEPENDENCY_ENABLED TRUE)
