//import 'package:alarmproject/signin.dart';
import 'package:alarmproject/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void signuserin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),

                    //Row(
                    // children: [
                    //  Container(
                    ///  width: 20,
                    // height: 20,
                    //  decoration: BoxDecoration(color: Colors.blue)),
                    //],
                    // ),
                    Center(
                      child: Column(
                        children: [
                          Lottie.asset("Lottie/slower.json", width: 250)
                        ],
                      ),
                    ),

                    Text("Welcome to Alarm-app etc",
                        style: GoogleFonts.mandali(
                            textStyle: const TextStyle(fontSize: 25),
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Login to start or sign up if youre new here!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mandali(
                            textStyle: const TextStyle(
                                fontSize: 28,
                                color: Color.fromARGB(255, 12, 12, 12),
                                fontWeight: FontWeight.bold)),
                      )
                          .animate()
                          .fade(delay: 500.ms, duration: 1000.ms)
                          .then()
                          .tint(color: const Color.fromARGB(255, 230, 40, 26)),
                    ),
                    // ------------
                    TextFields(
                        controller: emailcontroller,
                        hint: "Email",
                        obstext: false),
                    TextFields(
                        controller: passwordcontroller,
                        hint: "Password",
                        obstext: true),
                    Text(
                      "Forgot Password?",
                      style: GoogleFonts.mandali(
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 105, 105, 105))),
                    ),
                    //const SignUserIn()
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        return signuserin();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(250, 50),
                          foregroundColor: Color.fromARGB(255, 188, 39, 31),
                          side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(160, 221, 149, 149))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 3,
                            color: Color.fromARGB(255, 218, 217, 217),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or continue with",
                            style: TextStyle(
                                color: Color.fromARGB(255, 139, 138, 138)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 3,
                            color: Color.fromARGB(255, 218, 217, 217),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "Lottie/gogol.png",
                          width: 60,
                        ),
                        Image.asset(
                          "Lottie/apol.png",
                          width: 53,
                        )
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New here? ",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "Register now",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    // height: 50,
                    //)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class MyPainter extends CustomPainter {
 // @override
  //void paint(Canvas canvas, Size size) {
  //  canvas.drawRect(rect, paint);
  //}

  //@override
 // bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
   // throw UnimplementedError();
  //}
//}
