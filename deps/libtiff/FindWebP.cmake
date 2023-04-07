find_package(WebP CONFIG REQUIRED)

add_library(WebP::WebP ALIAS WebP::webp)

set(WEBP_FOUND TRUE)
