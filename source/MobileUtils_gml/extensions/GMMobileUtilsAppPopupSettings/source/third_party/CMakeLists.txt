cmake_minimum_required(VERSION 3.18)

# No third-party SDK for this extension — empty INTERFACE target so the
# parent CMakeLists' third_party wiring has something to link against.
add_library(ext_third_party INTERFACE)
