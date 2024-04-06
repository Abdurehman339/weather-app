import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MiddleWidget extends StatelessWidget {
  final String currentTemp;
  final String currentWeather;
  final String description;

  const MiddleWidget({
    required this.currentTemp,
    required this.currentWeather,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Container(
        width: double.infinity,
        // width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          border: Border.all(
            color: Colors.grey.withOpacity(0.02),
            width: 10,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Blur color
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '$currentTemp°',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentWeather,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Marquee(
                    text: description,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.2,
                    fadingEdgeEndFraction: 0.2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
