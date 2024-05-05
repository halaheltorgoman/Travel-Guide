import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFields2 extends StatelessWidget {
  final String tag;
  final String text;
  final void Function()? onPressed;

  const TextFields2({
    super.key,
    required this.tag,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 240, bottom: 10),
          child: Text(
            tag,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 17,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),
          margin: const EdgeInsets.only(left: 2),
          width: 330,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 31, 31, 31), width: 1),
            borderRadius: BorderRadius.circular(50.0),
            color: Color.fromRGBO(238, 238, 238, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 4.0,
                spreadRadius: 0,
              ), //BoxShadow
              //BoxShadow
            ], //BoxShadow
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
