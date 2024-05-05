import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFields3 extends StatelessWidget {
  final String tag;
  final String hint;

  const TextFields3({
    super.key,
    required this.tag,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 80, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 180, bottom: 16),
            child: Text(
              tag,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0))),
            ),
          ),
          SizedBox(
            height: 30,
            width: 250,
            child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                  fillColor: Color.fromRGBO(255, 255, 255, 1),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 0, bottom: 12),
                )),
          ),
        ],
      ),
    );
  }
}
