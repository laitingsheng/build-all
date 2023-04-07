macro (requires_windows NAME)
	if (NOT WIN32)
		message(STATUS "Ignoring ${NAME} (Windows only).")
		return ()
	endif ()
endmacro ()
