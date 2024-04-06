import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/API/search_city_if_exist/api_call.dart';
import 'package:weather_app/screens/specific_city_weather.dart';
import 'package:weather_app/utilities/list_tile.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({super.key});

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  late final TextEditingController _controller;
  late List<dynamic> _cities;
  bool _isFocused = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _cities = [];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cities.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isFocused ? Colors.grey[200] : Colors.black.withOpacity(0.4),
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          56.0,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: TextField(
                onTap: () {
                  setState(() {
                    _isFocused = true;
                  });
                },
                controller: _controller,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onChanged: (text) async {
                  final result = await fetchCities(text);
                  setState(() {
                    _cities.clear();
                    _cities = result;
                  });
                },
              ),
              elevation: 0.0,
              backgroundColor: Colors.black.withOpacity(0.2),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: ListView.builder(
          itemCount: _cities.length,
          itemBuilder: (context, index) {
            return FrostedListTile(
              title: _cities[index],
              onTap: () {
                _controller.text = _cities[index];
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SpecificCityWeather(
                      city: _controller.text.split(',')[0]);
                }));
              },
            );
          },
        ),
      ),
    );
  }
}
