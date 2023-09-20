# --------------------------------------------------------------
# Required CMake version
# --------------------------------------------------------------
cmake_minimum_required(VERSION 3.10)

# --------------------------------------------------------------
# Project name
# --------------------------------------------------------------
project(WeatherApp)

# --------------------------------------------------------------
# Options
# --------------------------------------------------------------
# Warning options
add_compile_options(-Wall)
add_compile_options(-Wextra)
add_compile_options(-Wconversion)

# Warning option Suppression
add_compile_options(-Wno-unused-parameter)
add_compile_options(-Wno-sign-conversion)

# C++ standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# --------------------------------------------------------------
# Include directories
# --------------------------------------------------------------
include_directories(include)

# --------------------------------------------------------------
# Target directories
# --------------------------------------------------------------
add_subdirectory(src)
