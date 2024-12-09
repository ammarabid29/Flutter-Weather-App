class Weather {
  final String locationName;
  final String weatherCondition;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.locationName,
    required this.weatherCondition,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });
}
