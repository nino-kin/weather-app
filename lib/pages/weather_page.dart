import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather_app/models/weather_model.dart";
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  static const apiKey = String.fromEnvironment('API_KEY', defaultValue: 'null');
  final _weatherService = WeatherService(apiKey);
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    // TODO: Could not get the current city via Web browser
    // String cityName = await _weatherService.getCurrentCity();
    String cityName = 'tokyo';

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/clouds.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city..",
                style: const TextStyle(
                    fontFamily: 'Murecho', fontSize: 30, color: Colors.white)),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text(
              '${_weather?.temperature.round()}°',
              style: const TextStyle(
                fontFamily: 'Murecho',
                fontSize: 50,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),

            // weather condition
            // Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
