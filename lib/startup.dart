import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:travelguide/authpage.dart';

// ignore: camel_case_types
class startUp extends StatefulWidget {
  const startUp({super.key});

  @override
  State<startUp> createState() => _startUpState();
}

// ignore: camel_case_types
class _startUpState extends State<startUp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: 300,
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 42, 2, 143),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2000),
                    bottomRight: Radius.circular(1000)),
              ),
              //bottom: PreferredSize(
              //preferredSize: Size.fromHeight(170), child: SizedBox()),
            ).animate().slideY(duration: 2000.ms),
          ),
          Container(
            height: 270,
            child: AppBar(
              backgroundColor: const Color.fromARGB(206, 85, 0, 255),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(1000),
                    bottomRight: Radius.circular(2000)),
              ),
              //bottom: PreferredSize(
              // preferredSize: Size.fromHeight(170), child: SizedBox()),
            ).animate().slideY(duration: 2000.ms, delay: 500.ms),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Container(
                alignment: Alignment.bottomRight,
                child: Lottie.asset("Lottie/plane.json", width: 200)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 250, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "YOUR OWN PRIVATE INCLUSIVE GUIDE",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    fontSize: 36,
                    color: Color.fromARGB(255, 12, 12, 12),
                  )),
                ).animate().fade(duration: 2000.ms).slideX(duration: 2000.ms),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Visit Your Dream \nDestination!",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 21,
                      color: Color.fromARGB(255, 235, 235, 235),
                    )),
                  ).animate().fade(delay: 2000.ms, begin: 0.1, end: 0.8).tint(
                      color: const Color.fromARGB(255, 47, 47, 47),
                      duration: 2000.ms),
                ),
                const SizedBox(
                  height: 120,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(0, 8),
                        )
                      ]),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(265, 60),
                        backgroundColor: const Color.fromARGB(255, 23, 23, 23),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AuthPage()));
                      },
                      child: const Text(
                        "START NOW",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
