import 'package:alarmproject/authpage.dart';
//import 'package:alarmproject/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                Center(child: Lottie.asset("Lottie/alarm.json", width: 100))
              ],
            ),
          ),
        ),
        nextScreen: const AuthPage(),
        backgroundColor: Color.fromARGB(255, 213, 211, 211),
        splashIconSize: 420,
      ),
    );
  }
}
