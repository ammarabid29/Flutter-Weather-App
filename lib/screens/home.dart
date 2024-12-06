import 'package:flutter/material.dart';
import 'package:flutter_weather_app/services/http_current_weather.dart';
import 'package:flutter_weather_app/widgets/custom_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpCurrentWeather currentWeather = HttpCurrentWeather();
  String location = '';
  String temperature = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentWeather();
  }

  Future<void> _getCurrentWeather() async {
    try {
      final currentLocationWeather = await currentWeather.getCurrentWeather();
      if (currentLocationWeather.isNotEmpty) {
        setState(() {
          location = currentLocationWeather['location'];
          temperature = currentLocationWeather['temperature'];
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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 29, bottom: 10, left: 52, right: 52),
                    child: TextField(
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
                      onSubmitted: (value) {},
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
                    "assets/images/Cloud.png",
                    height: 150,
                  ),
                  Text(
                    "20\u00B0C",
                    style: GoogleFonts.ubuntu(
                      color: const Color(0XFFFFFFFF),
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "overcast clouds",
                    style: GoogleFonts.ubuntu(
                      color: const Color(0XFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCard(
                        icon: "assets/images/feellike.png",
                        value: '20\u00B0C',
                        label: 'Feels like',
                      ),
                      SizedBox(width: 17),
                      CustomCard(
                        icon: "assets/images/humidity.png",
                        value: '10%',
                        label: 'Humidity',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCard(
                        icon: "assets/images/visibility.png",
                        value: '100000',
                        label: 'Visibility',
                      ),
                      SizedBox(width: 17),
                      CustomCard(
                        icon: "assets/images/windspeed.png",
                        value: '0.82 m/s',
                        label: 'Wind Speed',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCard(
                        icon: "assets/images/sunrise.png",
                        value: '5:12 AM',
                        label: 'Sunrise',
                      ),
                      SizedBox(width: 17),
                      CustomCard(
                        icon: "assets/images/sunset.png",
                        value: '6:45 PM',
                        label: 'Sunset',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
