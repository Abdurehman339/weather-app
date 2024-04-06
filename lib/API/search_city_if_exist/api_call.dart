import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/API/search_city_if_exist/api_key.dart';

Future<List<dynamic>> fetchCities(String input) async {
  final response = await http.get(Uri.parse(
      'https://api.geoapify.com/v1/geocode/autocomplete?text=$input&format=json&apiKey=$apiKey'));

  List<dynamic> cities = [];

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> results = data['results'];
    for (var result in results) {
      String city = ((result['city']).toString().split(' '))[0];
      String country = result['country'];
      cities.add("$city, $country");
    }
  } else {
    throw Exception('Failed to load cities');
  }
  return cities;
}
