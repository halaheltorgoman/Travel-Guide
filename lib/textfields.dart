import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final controller;
  Widget label() {
    return Text(hint);
  }

  final double width;
  final double height;
  final String hint;
  final bool obstext;
  const TextFields({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.hint,
    required this.obstext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 3, 15, 3),
      child: SizedBox(
        height: height,
        width: width,
        child: TextField(
          controller: controller,
          obscureText: obstext,
          decoration: InputDecoration(
              label: label(),
              fillColor: Color.fromRGBO(157, 186, 221, 0.46),
              filled: true,
              contentPadding: EdgeInsets.all(15),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(157, 186, 221, 0.285),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Color.fromARGB(255, 218, 218, 218)),
                  borderRadius: BorderRadius.circular(50.0))),
        ),
      ),
    );
  }
}
