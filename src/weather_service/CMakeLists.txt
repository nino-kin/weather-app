set(TARGET_NAME weather_service)

add_executable(${TARGET_NAME}
    weather_fetcher.cpp)

find_package(CURL REQUIRED)
find_package(fmt REQUIRED)
find_package(nlohmann_json 3.2.0 REQUIRED)

target_link_libraries(${TARGET_NAME} PRIVATE CURL::libcurl)
target_link_libraries(${TARGET_NAME} PRIVATE fmt::fmt)
target_link_libraries(${TARGET_NAME} PRIVATE nlohmann_json::nlohmann_json)
