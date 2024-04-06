import 'package:flutter/material.dart';
import 'package:weather_app/API/get_weather_of_given_city/api_call.dart';
import 'package:weather_app/services/weather_class.dart';
import 'package:weather_app/wigdets/bottom_widget.dart';
import 'package:weather_app/wigdets/middle_widget.dart';

class SpecificCityWeather extends StatefulWidget {
  final String city;
  const SpecificCityWeather({
    Key? key,
    required this.city,
  });

  @override
  State<SpecificCityWeather> createState() =>
      _SpecificCityWeatherState(city: this.city);
}

class _SpecificCityWeatherState extends State<SpecificCityWeather> {
  String city;

  _SpecificCityWeatherState({required this.city});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: fetchWeather(city),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return buildSpecificCityWeather(snapshot.data!);
        }
      },
    );
  }

  Widget buildSpecificCityWeather(Weather weatherData) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, Colors.black],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.4),
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: const ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image(
                image: AssetImage('assets/moon.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              city, // Use weather data to set the title
              style: const TextStyle(fontSize: 35),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MiddleWidget(
                    currentTemp: weatherData
                        .currentTemp, // Use weather data for current temperature
                    currentWeather: weatherData
                        .currentWeather, // Use weather data for current weather
                    description: weatherData
                        .description, // Use weather data for description
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BottomWidget(
                        image: 'assets/thermometer.png',
                        title: 'Feels Like',
                        content:
                            '${weatherData.feelsLike}°', // Use weather data for feels like temperature
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      BottomWidget(
                        image: 'assets/visibility.png',
                        title: 'Visibility',
                        content:
                            '${weatherData.visibility}m', // Use weather data for visibility
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      BottomWidget(
                        image: 'assets/humidity.png',
                        title: 'Humidity',
                        content:
                            '${weatherData.humidity}%', // Use weather data for humidity
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BottomWidget(
                        image: 'assets/wind.png',
                        title: 'Wind',
                        content:
                            '${weatherData.wind}m/s', // Use weather data for wind
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      BottomWidget(
                        image: 'assets/weather.png',
                        title: 'Pressure',
                        content:
                            '${weatherData.pressure}hPa', // Use weather data for pressure
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      BottomWidget(
                        image: 'assets/maxTemp.png',
                        title: 'Max Temp',
                        content:
                            '${weatherData.maxTemp}°', // Use weather data for max temperature
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
