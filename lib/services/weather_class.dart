class Weather {
  final String currentTemp;
  final String currentWeather;
  final String description;
  final String feelsLike;
  final String visibility;
  final String wind;
  final String humidity;
  final String pressure;
  final String maxTemp;
  final String city;

  const Weather({
    required this.currentTemp,
    required this.currentWeather,
    required this.description,
    required this.feelsLike,
    required this.visibility,
    required this.wind,
    required this.humidity,
    required this.pressure,
    required this.maxTemp,
    required this.city,
  });

  Weather.fromAPI(Map<String, dynamic> weather)
      : currentTemp = ((weather['main']['temp']).round()).toString(),
        currentWeather = weather['weather'][0]['main'].toString(),
        description = weather['weather'][0]['description'].toString(),
        feelsLike = ((weather['main']['feels_like']).round()).toString(),
        visibility = weather['visibility'].toString(),
        wind = weather['wind']['speed'].toString(),
        humidity = weather['main']['humidity'].toString(),
        pressure = weather['main']['pressure'].toString(),
        maxTemp = ((weather['main']['temp_max']).round()).toString(),
        city = (weather['city']).toString();
}
