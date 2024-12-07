import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/http_current_weather.dart';
import 'package:flutter_weather_app/widgets/custom_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpCurrentWeather currentWeather = HttpCurrentWeather();

  TextEditingController cityController = TextEditingController();

  String location = '';
  String weatherCondition = '';
  String temperature = '';
  String feelsLike = '';
  String humidity = '';
  String visibility = '';
  String windSpeed = '';
  String sunrise = '';
  String sunset = '';
  String weatherImage = '';

  String city = '';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentWeather();
  }

  String formatTime(int timestamp) {
    return DateFormat('hh:mm a').format(
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toLocal());
  }

  Future<void> _getCurrentWeather() async {
    try {
      final currentLocationWeather = await currentWeather.getCurrentWeather();
      if (currentLocationWeather.isNotEmpty) {
        setState(() {
          location = currentLocationWeather['location'];
          weatherCondition = currentLocationWeather['weatherCondition'];
          temperature = currentLocationWeather['temperature'];
          feelsLike = currentLocationWeather['feelsLike'];
          humidity = currentLocationWeather['humidity'];
          visibility = currentLocationWeather['visibility'];
          windSpeed = currentLocationWeather['windSpeed'];
          sunrise = currentLocationWeather['sunrise'];
          sunset = currentLocationWeather['sunset'];

          if (weatherCondition.toLowerCase() == 'clouds') {
            weatherImage = "assets/images/Cloud.png";
          } else if (weatherCondition.toLowerCase() == 'thunderstorm') {
            weatherImage = "assets/images/Thunder.png";
          } else if (weatherCondition.toLowerCase() == 'drizzle') {
            weatherImage = "assets/images/Raining.png";
          } else if (weatherCondition.toLowerCase() == 'rain') {
            weatherImage = "assets/images/Raining.png";
          } else if (weatherCondition.toLowerCase() == 'snow') {
            weatherImage = "assets/images/Snowy.png";
          } else if (weatherCondition.toLowerCase() == 'atmosphere') {
            weatherImage = "assets/images/Sunny.png";
          } else if (weatherCondition.toLowerCase() == 'clear') {
            weatherImage = "assets/images/Sunny.png";
          } else if (weatherCondition.toLowerCase() == 'extreme weather') {
          } else if (weatherCondition.toLowerCase() == 'sunny') {
            weatherImage = "assets/images/Sunny.png";
          } else if (weatherCondition.toLowerCase() == 'extreme weather') {
            weatherImage = "assets/images/Thunder.png";
          } else {
            weatherImage = "assets/images/Wave.png";
          }

          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching weather data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getCityWeather(String city) async {
    setState(() {
      isLoading = true;
    });
    try {
      final cityWeather = await currentWeather.getCityWeather(city);
      if (cityWeather.isNotEmpty) {
        setState(() {
          location = cityWeather['location'];
          weatherCondition = cityWeather['weatherCondition'];
          temperature = cityWeather['temperature'];
          feelsLike = cityWeather['feelsLike'];
          humidity = cityWeather['humidity'];
          visibility = cityWeather['visibility'];
          windSpeed = cityWeather['windSpeed'];
          sunrise = cityWeather['sunrise'];
          sunset = cityWeather['sunset'];

          if (weatherCondition.toLowerCase() == 'clouds') {
            weatherImage = "assets/images/Cloud.png";
          } else if (weatherCondition.toLowerCase() == 'thunderstorm') {
            weatherImage = "assets/images/Thunder.png";
          } else if (weatherCondition.toLowerCase() == 'drizzle') {
            weatherImage = "assets/images/Raining.png";
          } else if (weatherCondition.toLowerCase() == 'rain') {
            weatherImage = "assets/images/Raining.png";
          } else if (weatherCondition.toLowerCase() == 'snow') {
            weatherImage = "assets/images/Snowy.png";
          } else if (weatherCondition.toLowerCase() == 'atmosphere') {
            weatherImage = "assets/images/Sunny.png";
          } else if (weatherCondition.toLowerCase() == 'clear') {
            weatherImage = "assets/images/Sunny.png";
          } else if (weatherCondition.toLowerCase() == 'extreme weather') {
          } else if (weatherCondition.toLowerCase() == 'sunny') {
            weatherImage = "assets/images/Sunny.png";
          } else if (weatherCondition.toLowerCase() == 'extreme weather') {
            weatherImage = "assets/images/Thunder.png";
          } else {
            weatherImage = "assets/images/Wave.png";
          }

          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching weather data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      content = SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 29, bottom: 10, left: 52, right: 52),
              child: TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  hintText: 'Search City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(39),
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                onSubmitted: (value) {
                  _getCityWeather(value);
                },
              ),
            ),
            Text(
              location,
              style: GoogleFonts.ubuntu(
                color: const Color(0XFFFFFFFF),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              weatherImage,
              height: 150,
            ),
            Text(
              "$temperature\u00B0C",
              style: GoogleFonts.ubuntu(
                color: const Color(0XFFFFFFFF),
                fontSize: 50,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              weatherCondition,
              style: GoogleFonts.ubuntu(
                color: const Color(0XFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  icon: "assets/images/feellike.png",
                  value: '$feelsLike\u00B0C',
                  label: 'Feels like',
                ),
                const SizedBox(width: 17),
                CustomCard(
                  icon: "assets/images/humidity.png",
                  value: '$humidity%',
                  label: 'Humidity',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  icon: "assets/images/visibility.png",
                  value: visibility,
                  label: 'Visibility',
                ),
                const SizedBox(width: 17),
                CustomCard(
                  icon: "assets/images/windspeed.png",
                  value: '$windSpeed m/s',
                  label: 'Wind Speed',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  icon: "assets/images/sunrise.png",
                  value: formatTime(int.parse(sunrise)),
                  label: 'Sunrise',
                ),
                const SizedBox(width: 17),
                CustomCard(
                  icon: "assets/images/sunset.png",
                  value: formatTime(int.parse(sunset)),
                  label: 'Sunset',
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF05406B),
                    Color(0xFF22699D),
                    Color(0xFF05406B),
                    Color(0xFF05406B),
                  ],
                ),
              ),
              child: content),
        ),
      ),
    );
  }
}
