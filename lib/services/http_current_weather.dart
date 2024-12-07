import 'dart:convert' as convert;

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HttpCurrentWeather {
  static const String _currentWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?lat=";
  static const String _cityWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather?units=metric&q=";
  static const String _key = "ef62f1f3478b62403a50c4edb64f239e";

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled');
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return null;
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future getCurrentWeather() async {
    try {
      Position? position = await _getCurrentLocation();
      if (position != null) {
        Uri weatherUri = Uri.parse(
            '$_currentWeatherUrl${position.latitude}&lon=${position.longitude}&appid=$_key');
        http.Response response = await http.get(weatherUri);

        if (response.statusCode == 200) {
          var data = convert.jsonDecode(response.body);
          String locationName = data['name'];
          String weatherCondition = data['weather'][0]['main'];
          double temperature = data['main']['temp'] - 273.15;
          double feelsLike = data['main']['feels_like'] - 273.15;
          int humidity = data['main']['humidity'];
          int visibility = data['visibility'];
          double windSpeed = data['wind']['speed'];
          int sunrise = data['sys']['sunrise'];
          int sunset = data['sys']['sunset'];

          if (weatherCondition.toLowerCase() == 'clouds') {}

          print('Weather data: $data');

          return {
            'location': locationName.toString(),
            'weatherCondition': weatherCondition.toString(),
            'temperature': temperature.toStringAsFixed(2),
            'feelsLike': feelsLike.toStringAsFixed(2),
            'humidity': humidity.toString(),
            'visibility': visibility.toString(),
            'windSpeed': windSpeed.toString(),
            'sunrise': sunrise.toString(),
            'sunset': sunset.toString(),
          };
        } else {
          print('Failed to load weather data');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getCityWeather(String city) async {
    try {
      Position? position = await _getCurrentLocation();
      if (position != null) {
        Uri weatherUri = Uri.parse('$_cityWeatherUrl$city&appid=$_key');
        http.Response response = await http.get(weatherUri);
        if (response.statusCode == 200) {
          var data = convert.jsonDecode(response.body);
          String locationName = data['name'];
          String weatherCondition = data['weather'][0]['main'];
          double temperature = data['main']['temp'];
          double feelsLike = data['main']['feels_like'];
          int humidity = data['main']['humidity'];
          int visibility = data['visibility'];
          double windSpeed = data['wind']['speed'];
          int sunrise = data['sys']['sunrise'];
          int sunset = data['sys']['sunset'];

          print('Weather data: $data');

          return {
            'location': locationName.toString(),
            'weatherCondition': weatherCondition.toString(),
            'temperature': temperature.toStringAsFixed(2),
            'feelsLike': feelsLike.toStringAsFixed(2),
            'humidity': humidity.toString(),
            'visibility': visibility.toString(),
            'windSpeed': windSpeed.toString(),
            'sunrise': sunrise.toString(),
            'sunset': sunset.toString(),
          };
        } else {
          print('Failed to load weather data');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
