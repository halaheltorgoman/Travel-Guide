//import 'package:travelguide/signin.dart';
import 'package:travelguide/google_apple.dart';
import 'package:travelguide/services/google_auth.dart';
import 'package:travelguide/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class RegisterUser extends StatefulWidget {
  final Function()? onTap;
  const RegisterUser({super.key, required this.onTap});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  void signuserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      if (passwordcontroller.text == confirmpasswordcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
      } else {
        showErrormsg("Passwords don't match");
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrormsg(e.code);
    }
  }

  void showErrormsg(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(235, 249, 187, 3),
            title: Center(
                child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
              ),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
            Color.fromARGB(255, 187, 178, 178),
            Color.fromARGB(255, 232, 232, 232)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      //const SizedBox(
                      //height: 3,
                      //),

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
                            Lottie.asset("Lottie/slower.json", width: 200)
                          ],
                        ),
                      ),

                      Text(
                          "Welcome to Alarm-app etc \n Let's create an account for you",
                          style: GoogleFonts.mandali(
                              textStyle: const TextStyle(fontSize: 25),
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center),
                      const SizedBox(
                        height: 20,
                      ),

                      // ------------
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFields(
                            controller: emailcontroller,
                            hint: "Email",
                            obstext: false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFields(
                            controller: passwordcontroller,
                            hint: "Password",
                            obstext: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: TextFields(
                            controller: confirmpasswordcontroller,
                            hint: "Confirm Password",
                            obstext: true),
                      ),

                      //const SignUserIn()
                      const SizedBox(
                        height: 30,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          return signuserUp();
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            fixedSize: Size(200, 55),
                            backgroundColor: Color.fromARGB(181, 170, 0, 0),
                            foregroundColor:
                                const Color.fromARGB(255, 251, 251, 251),
                            side: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 3,
                              color: Color.fromRGBO(177, 177, 177, 1),
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
                              color: Color.fromRGBO(177, 177, 177, 1),
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
                          Tapableicon(
                            onTap: () => GoogleAuth().signInWithGoogle(),
                            imagepath: "Lottie/gogol.png",
                            height: 40,
                          ),
                          Tapableicon(
                            onTap: () {},
                            imagepath: "Lottie/apol.png",
                            height: 40,
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(fontSize: 17),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                "Login Here",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 17),
                              ),
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
      ),
    );
  }
}
