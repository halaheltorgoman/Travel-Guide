import 'package:flutter/material.dart';

class Tapableicon extends StatelessWidget {
  final Function()? onTap;
  final String imagepath;
  final double height;
  const Tapableicon(
      {super.key,
      required this.imagepath,
      required this.onTap,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          imagepath,
          height: height,
        ),
      ),
    );
  }
}
