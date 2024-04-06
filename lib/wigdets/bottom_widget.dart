import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  const BottomWidget({
    required this.image,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.01),
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover, // Adjusted fit
                ),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontWeight: FontWeight.bold), // Centered text
            ),
            Text(
              content,
              textAlign: TextAlign.center, // Centered text
            ),
          ],
        ),
      ),
    );
  }
}
