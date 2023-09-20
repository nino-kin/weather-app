# --------------------------------------------------------------
# Required CMake version
# --------------------------------------------------------------
cmake_minimum_required(VERSION 3.10)

# --------------------------------------------------------------
# Target name
# --------------------------------------------------------------
set(TARGET_NAME weather_service)

# --------------------------------------------------------------
# Packages
# --------------------------------------------------------------
find_package(CURL REQUIRED)
find_package(fmt REQUIRED)
find_package(nlohmann_json 3.2.0 REQUIRED)

# --------------------------------------------------------------
# Executables
# --------------------------------------------------------------
add_executable(${TARGET_NAME}
    weather_fetcher.cpp)

# --------------------------------------------------------------
# Target link libraries
# --------------------------------------------------------------
target_link_libraries(${TARGET_NAME} PRIVATE CURL::libcurl)
target_link_libraries(${TARGET_NAME} PRIVATE fmt::fmt)
target_link_libraries(${TARGET_NAME} PRIVATE nlohmann_json::nlohmann_json)
