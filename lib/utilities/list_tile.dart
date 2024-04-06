import 'package:flutter/material.dart';

typedef Tap = void Function();

class FrostedListTile extends StatelessWidget {
  final String title;
  final Tap onTap;

  const FrostedListTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        right: 5,
        left: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.5), // Frosted effect color
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Set the border radius
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
