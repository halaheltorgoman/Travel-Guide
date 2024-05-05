//import 'package:travelguide/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:travelguide/google_apple.dart';
import 'package:travelguide/services/google_auth.dart';
import 'package:travelguide/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_animate/flutter_animate.dart';
//import 'package:lottie/lottie.dart';

class RegisterUser extends StatefulWidget {
  final Function()? onTap;
  const RegisterUser({super.key, required this.onTap});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final storageRef = FirebaseStorage.instance.ref();

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
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': emailcontroller.text.split('@')[0],
          'email': emailcontroller.text,
          'password': passwordcontroller.text,
          'from': "",
        });
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
            buttonPadding: const EdgeInsets.all(8),
            backgroundColor: const Color.fromARGB(250, 184, 1, 1),
            title: Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: 250,
              child: AppBar(
                backgroundColor: Color.fromARGB(255, 42, 2, 143),
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
              height: 220,
              child: AppBar(
                backgroundColor: const Color.fromARGB(206, 85, 0, 255),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(500),
                      bottomRight: Radius.circular(1000)),
                ),
                //bottom: PreferredSize(
                // preferredSize: Size.fromHeight(170), child: SizedBox()),
              ).animate().slideY(duration: 2000.ms, delay: 500.ms),
            ),
            SingleChildScrollView(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 245),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Visit Your Dream \nDestination!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 21,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Welcome",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                      ),
                      Text(
                        "Start your Trip Now!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)),
                      ),
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                TextFields(
                                    height: 45.0,
                                    width: 310,
                                    controller: emailcontroller,
                                    hint: "Email",
                                    obstext: false),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFields(
                                    height: 45.0,
                                    width: 310,
                                    controller: passwordcontroller,
                                    hint: "Password",
                                    obstext: true),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFields(
                                    height: 45.0,
                                    width: 310,
                                    controller: confirmpasswordcontroller,
                                    hint: "Confirm Password",
                                    obstext: true)
                              ],
                            ),
                            const SizedBox(
                              height: 30,
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
                                      offset: Offset(0, 8),
                                    )
                                  ]),
                              child: ElevatedButton(
                                onPressed: () {
                                  return signuserUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 12, 12, 12),
                                  minimumSize: const Size(160, 50),
                                ),
                                child: Text(
                                  "SIGN UP",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: Color.fromRGBO(204, 204, 204, 1),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Or continue with",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 139, 138, 138)),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    color: Color.fromRGBO(204, 204, 204, 1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Tapableicon(
                                  onTap: () => GoogleAuth().signInWithGoogle(),
                                  imagepath: "Lottie/gogol.png",
                                  height: 55,
                                ),
                                Tapableicon(
                                  onTap: () {},
                                  imagepath: "Lottie/apol.png",
                                  height: 45,
                                )
                              ],
                            ),
                            Padding(
                              //,,
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account? ",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                  ),
                                  GestureDetector(
                                    onTap: widget.onTap,
                                    child: Text(
                                      "Login Here",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 23, 154, 255))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
