import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/API/lat_lon%20to%20city_name/api_key.dart';
import 'package:weather_app/utilities/location/get_current_lat_and_lon.dart';

class FailedToFethCity implements Exception {}

Future<String> fetchCity() async {
  //Getting Lat and Lon
  final position = await determinePosition();
  String lat = (position.latitude).toString();
  String lon = (position.longitude).toString();

  //Getting city name from Lat and Lon
  final response = await http.get(Uri.parse(
      'https://api.opencagedata.com/geocode/v1/json?q=$lat%2C$lon&key=$apiKey'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    String cityName = ((data["results"][0]["annotations"]["timezone"]["name"])
        .toString()
        .split('/'))[1];
    return cityName;
  } else {
    throw FailedToFethCity();
  }
}
