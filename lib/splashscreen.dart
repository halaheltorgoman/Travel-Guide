//import 'package:travelguide/authpage.dart';
//import 'package:travelguide/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:travelguide/startup.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          duration: 2000,
          splash: SingleChildScrollView(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Lottie.asset("Lottie/loading.json", width: 300)),
                  Lottie.asset("Lottie/bar.json", width: 300)
                ],
              ),
            ),
          ),
          nextScreen: const startUp(),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          splashIconSize: 420,
        ),
      ),
    );
  }
}
