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
# --------------------------------------------------------------
# Debug information
# --------------------------------------------------------------
# Top directory of the source tree (directory with top-level CMakeLists.txt)
message(STATUS "CMAKE_SOURCE_DIR=${CMAKE_SOURCE_DIR}")
# Build directory corresponding to the CMAKE_SOURCE_DIR
message(STATUS "CMAKE_BINARY_DIR=${CMAKE_BINARY_DIR}")
# Directory with CMakeLists.txt currently being processed
message(STATUS "CMAKE_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}")
# Build directory corresponding to the CMAKE_CURRENT_BINARY_DIR
message(STATUS "CMAKE_CURRENT_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}")
# Top Directory of current project (directory with project command CMakeLists.txt)
message(STATUS "PROJECT_SOURCE_DIR=${PROJECT_SOURCE_DIR}")
# Build directory corresponding to the PROJECT_SOURCE_DIR
message(STATUS "PROJECT_BINARY_DIR=${PROJECT_BINARY_DIR}")
# CMake Cross Compiling variable
message(STATUS "CMAKE_CROSSCOMPILING=${CMAKE_CROSSCOMPILING}")
# The name of the CPU CMake is building for.s
message(STATUS "CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")
# The name of the CPU CMake is running on.
message(STATUS "CMAKE_HOST_SYSTEM_PROCESSOR=${CMAKE_HOST_SYSTEM_PROCESSOR}")
# List of features known to the C compiler
message(STATUS "CMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
# List of features known to the C++ compiler
message(STATUS "CMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}")
# read-only single-machine data
message(STATUS "CMAKE_INSTALL_SYSCONFDIR=${CMAKE_INSTALL_SYSCONFDIR}")
# Install directory used by install()
message(STATUS "CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}")
