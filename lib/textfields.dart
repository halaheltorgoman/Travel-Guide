import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final controller;
  final String hint;
  final bool obstext;
  const TextFields({
    super.key,
    required this.controller,
    required this.hint,
    required this.obstext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
      child: TextField(
        controller: controller,
        obscureText: obstext,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 190, 190, 190),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: Color.fromARGB(255, 144, 217, 7)),
                borderRadius: BorderRadius.circular(50.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 3, color: Color.fromARGB(255, 241, 243, 239)),
                borderRadius: BorderRadius.circular(50.0))),
      ),
    );
  }
}
