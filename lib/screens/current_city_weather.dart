import 'package:flutter/material.dart';
import 'package:weather_app/API/get_weather_of_given_city/api_call.dart';
import 'package:weather_app/services/weather_class.dart';
import 'package:weather_app/wigdets/bottom_widget.dart';
import 'package:weather_app/wigdets/middle_widget.dart';
import 'package:weather_app/wigdets/search_wirdget.dart';

class CurrentCityWeather extends StatefulWidget {
  const CurrentCityWeather({
    Key? key,
  });

  @override
  State<CurrentCityWeather> createState() => _CurrentCityWeatherState();
}

class _CurrentCityWeatherState extends State<CurrentCityWeather> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: fetchWeather(null),
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
          return buildCurrentCityWeather(snapshot.data!);
        }
      },
    );
  }

  Widget buildCurrentCityWeather(Weather weatherData) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.deepPurple, Colors.black],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.4),
          child: AppBar(
            flexibleSpace: const ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image(
                image: AssetImage('assets/moon.png'),
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              weatherData.city,
              style: const TextStyle(fontSize: 35),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          const TopWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                iconSize: 40.0,
                color: Colors.white,
              ),
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            )),
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
                            'temp ${weatherData.maxTemp}°', // Use weather data for max temperature
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
