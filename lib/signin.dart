import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUserIn extends StatefulWidget {
  const SignUserIn({super.key});

  @override
  State<SignUserIn> createState() => _SignUserInState();
}

class _SignUserInState extends State<SignUserIn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
      child: Container(
          width: 300,
          height: 60,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color.fromARGB(255, 199, 51, 40),
                Color.fromARGB(255, 176, 22, 11),
                Color.fromARGB(255, 211, 29, 16)
              ]),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              color: Color.fromARGB(255, 136, 12, 4)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text("Sign In",
                textAlign: TextAlign.center,
                style: GoogleFonts.mandali(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 28),
                )),
          )),
    );
  }
}
