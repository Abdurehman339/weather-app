import 'package:weather_app/API/get_weather_of_given_city/api_key.dart';
import 'package:weather_app/API/lat_lon%20to%20city_name/api_call.dart';
import 'package:weather_app/services/weather_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UnableToFetchWeather implements Exception {}

Future<Weather> fetchWeather(String? city) async {
  if (city != null) {
    try {
      //Hitting Api endpoint
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
      );
      //decoding response body
      Map<String, dynamic> weatherData = json.decode(response.body);
      weatherData['city'] = city;
      //returning the weather object
      return Weather.fromAPI(weatherData);
    } catch (e) {
      throw UnableToFetchWeather();
    }
  } else {
    try {
      final city = await fetchCity();
      //Hitting Api endpoint
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
      );
      //decoding response body
      Map<String, dynamic> weatherData = json.decode(response.body);
      weatherData['city'] = city;
      //returning the weather object
      return Weather.fromAPI(weatherData);
    } catch (e) {
      throw UnableToFetchWeather();
    }
  }
}
