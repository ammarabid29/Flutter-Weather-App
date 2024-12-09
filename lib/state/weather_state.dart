import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/services/http_current_weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);

@immutable
abstract class WeatherState {}

class InitialWeatherState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  WeatherLoadedState({required this.currentWeather});

  final Weather currentWeather;
}

class ErrorWeatherState extends WeatherState {
  ErrorWeatherState({required this.message});

  final String message;
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(InitialWeatherState());
  final HttpCurrentWeather _httpGetWeather = HttpCurrentWeather();

  void fetchCurrentLocationWeather() async {
    try {
      state = WeatherLoadingState();
      final currentWeather = await _httpGetWeather.getCurrentWeather();
      state = WeatherLoadedState(currentWeather: currentWeather);
    } catch (e) {
      state = ErrorWeatherState(message: e.toString());
    }
  }

  void fetchCityWeather(String city) async {
    try {
      state = WeatherLoadingState();
      final currentWeather = await _httpGetWeather.getCityWeather(city);
      state = WeatherLoadedState(currentWeather: currentWeather);
    } catch (e) {
      state = ErrorWeatherState(message: e.toString());
    }
  }
}
