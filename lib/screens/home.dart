import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/state/weather_state.dart';
import 'package:flutter_weather_app/widgets/custom_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      ref.watch(weatherProvider.notifier).fetchCurrentLocationWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController weatherImageController = TextEditingController();

    String formatTime(int timestamp) {
      return DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(timestamp * 1000).toLocal());
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   ref.watch(weatherProvider.notifier).fetchCurrentLocationWeather();
      // }),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              minWidth: MediaQuery.of(context).size.width),
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
            child: Consumer(
              builder: (ctx, provider, child) {
                WeatherState state = ref.watch(weatherProvider);

                if (state is WeatherLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ErrorWeatherState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is WeatherLoadedState) {
                  String weatherImage = '';
                  if (state.currentWeather.weatherCondition.toLowerCase() ==
                      'clouds') {
                    weatherImage = "assets/images/Cloud.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'thunderstorm') {
                    weatherImage = "assets/images/Thunder.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'drizzle') {
                    weatherImage = "assets/images/Raining.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'rain') {
                    weatherImage = "assets/images/Raining.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'snow') {
                    weatherImage = "assets/images/Snowy.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'atmosphere') {
                    weatherImage = "assets/images/Sunny.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'clear') {
                    weatherImage = "assets/images/Sunny.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'extreme weather') {
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'sunny') {
                    weatherImage = "assets/images/Sunny.png";
                  } else if (state.currentWeather.weatherCondition
                          .toLowerCase() ==
                      'extreme weather') {
                    weatherImage = "assets/images/Thunder.png";
                  } else {
                    weatherImage = "assets/images/Wave.png";
                  }

                  return SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 29, bottom: 10, left: 52, right: 52),
                          child: TextField(
                            controller: weatherImageController,
                            decoration: const InputDecoration(
                              hintText: 'Search weatherImage',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(39),
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 25),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            onSubmitted: (value) {
                              ref
                                  .read(weatherProvider.notifier)
                                  .fetchCityWeather(value);
                            },
                          ),
                        ),
                        Text(
                          state.currentWeather.locationName,
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
                          "${state.currentWeather.temperature.toStringAsFixed(2)}\u00B0C",
                          style: GoogleFonts.ubuntu(
                            color: const Color(0XFFFFFFFF),
                            fontSize: 50,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          state.currentWeather.weatherCondition,
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
                              value:
                                  '${state.currentWeather.feelsLike.toStringAsFixed(2)}\u00B0C',
                              label: 'Feels like',
                            ),
                            const SizedBox(width: 17),
                            CustomCard(
                              icon: "assets/images/humidity.png",
                              value: '${state.currentWeather.humidity}%',
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
                              value: '${state.currentWeather.visibility}',
                              label: 'Visibility',
                            ),
                            const SizedBox(width: 17),
                            CustomCard(
                              icon: "assets/images/windspeed.png",
                              value: '${state.currentWeather.windSpeed} m/s',
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
                              value: formatTime(
                                  int.parse("${state.currentWeather.sunrise}")),
                              label: 'Sunrise',
                            ),
                            const SizedBox(width: 17),
                            CustomCard(
                              icon: "assets/images/sunset.png",
                              value: formatTime(
                                  int.parse("${state.currentWeather.sunset}")),
                              label: 'Sunset',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const Text("Nothing found");
              },
            ),
          ),
        ),
      ),
    );
  }
}
