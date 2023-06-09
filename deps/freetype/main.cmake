include_guard(GLOBAL)

message(STATUS "Using ${DEPENDENCY_VERSION} of ${DEPENDENCY}.")

string(REPLACE "." "-" VERSION_STRING "${DEPENDENCY_VERSION}")

ExternalProject_Add("${DEPENDENCY}"
	${EP_BASE_LOCATION_ARGS}
	GIT_REPOSITORY "${GITHUB_PREFIX}freetype/freetype.git"
	GIT_TAG "VER-${VERSION_STRING}"
	${EP_GIT_ARGS}
	${EP_CMAKE_DEFAULT_GENERATOR}
	CMAKE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_ARGS}
	CMAKE_CACHE_ARGS
		${EP_CMAKE_DEFAULT_CONFIGURE_CACHE_ARGS}
		"-DBUILD_SHARED_LIBS:BOOL=FALSE"
		"-DFT_REQUIRE_ZLIB:BOOL=TRUE"
		"-DFT_REQUIRE_BZIP2:BOOL=TRUE"
		"-DFT_REQUIRE_PNG:BOOL=TRUE"
		"-DFT_REQUIRE_BROTLI:BOOL=TRUE"
		"-DFT_ENABLE_ERROR_STRINGS:BOOL=TRUE"
	CONFIGURE_HANDLED_BY_BUILD TRUE
	${EP_WITH_BUILD_EXTRA_ARGS}
	DEPENDS
		"brotli"
		"bzip2"
		"libpng"
		"zlib"
	EXCLUDE_FROM_ALL TRUE
	STEP_TARGETS
		"install"
)

ExternalProject_Add_Step("${DEPENDENCY}" "reconfigure"
	COMMAND
		"${CMAKE_COMMAND}"
		"-S" "<SOURCE_DIR>"
		"-B" "<BINARY_DIR>"
		"-DFT_REQUIRE_HARFBUZZ:BOOL=TRUE"
	DEPENDEES
		"install"
	LOG TRUE
)
ExternalProject_Add_Step("${DEPENDENCY}" "rebuild"
	COMMAND
		"${CMAKE_COMMAND}"
		"--build" "<BINARY_DIR>"
	DEPENDEES
		"reconfigure"
	LOG TRUE
)
ExternalProject_Add_Step("${DEPENDENCY}" "reinstall"
	COMMAND
		"${CMAKE_COMMAND}"
		"--install" "<BINARY_DIR>"
		"--prefix" "<INSTALL_DIR>"
	DEPENDEES
		"rebuild"
	LOG TRUE
)

set(DEPENDENCY_ENABLED TRUE)
