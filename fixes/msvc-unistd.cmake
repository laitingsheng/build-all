file(WRITE "${CMAKE_PREFIX_PATH}/include/unistd.h"
[[
#ifndef _UNISTD_H
#define _UNISTD_H 1

#include <stdlib.h>
#include <io.h>
#include <process.h>
#include <direct.h>

#endif
]]
)
