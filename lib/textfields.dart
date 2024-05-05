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
              labelStyle: TextStyle(color: Color.fromRGBO(49, 0, 172, 1)),
              fillColor: Color.fromRGBO(202, 217, 236, 1),
              filled: true,
              contentPadding: EdgeInsets.all(15),
              //hintText: hint,
              // hintStyle: const TextStyle(
              //color: Color.fromRGBO(123, 147, 171, 1),

              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 1.2, color: Color.fromRGBO(49, 0, 172, 1)),
                  borderRadius: BorderRadius.circular(50.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(50.0))),
        ),
      ),
    );
  }
}
