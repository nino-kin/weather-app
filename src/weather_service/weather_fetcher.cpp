#include <iostream>
#include <curl/curl.h>
#include <nlohmann/json.hpp>

const std::string CITY_NAME = "Tokyo";

size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* output) {
    size_t totalSize = size * nmemb;
    output->append(static_cast<char*>(contents), totalSize);
    return totalSize;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <API_KEY>" << std::endl;
        return 1;
    }

    const std::string API_KEY = argv[1];
    CURL* curl;
    CURLcode res;
    std::string apiResponse;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if (curl) {
        std::string apiKey = API_KEY;
        std::string city = CITY_NAME;

        std::string apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&appid=" + apiKey;

        curl_easy_setopt(curl, CURLOPT_URL, apiUrl.c_str());
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &apiResponse);

        res = curl_easy_perform(curl);

        if (res != CURLE_OK) {
            std::cerr << "curl_easy_perform() failed: " << curl_easy_strerror(res) << std::endl;
        } else {
            // Parse JSON
            nlohmann::json jsonData = nlohmann::json::parse(apiResponse);

            // Get weather information
            std::string weatherDescription = jsonData["weather"][0]["description"];
            double temperature = jsonData["main"]["temp"];
            int humidity = jsonData["main"]["humidity"];

            std::cout << "City: " << city << std::endl;
            std::cout << "Weather: " << weatherDescription << std::endl;
            std::cout << "Temperature: " << temperature << " K" << std::endl;
            std::cout << "Humidity: " << humidity << "%" << std::endl;
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();

    return 0;
}
