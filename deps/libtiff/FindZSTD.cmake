find_package(ZSTD CONFIG REQUIRED)

add_library(ZSTD::ZSTD ALIAS zstd::libzstd_static)

set(ZSTD_FOUND TRUE)
set(ZSTD_HAVE_DECOMPRESS_STREAM TRUE)
