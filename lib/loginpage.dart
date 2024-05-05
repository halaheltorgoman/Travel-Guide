//import 'package:travelguide/signin.dart';
import 'package:travelguide/forgotpass.dart';
import 'package:travelguide/google_apple.dart';
import 'package:travelguide/services/google_auth.dart';
import 'package:travelguide/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
//import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  void signuserin() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
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
              height: 270,
              child: AppBar(
                backgroundColor: Color.fromARGB(255, 42, 2, 143),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(2000),
                      bottomRight: Radius.circular(1000)),
                ),
                //bottom: PreferredSize(
                //preferredSize: Size.fromHeight(170), child: SizedBox()),
              ),
            ),
            Container(
              height: 240,
              child: AppBar(
                backgroundColor: Color.fromARGB(206, 85, 0, 255),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(2000)),
                ),
                //bottom: PreferredSize(
                // preferredSize: Size.fromHeight(170), child: SizedBox()),
              ).animate().slideY(duration: 2000.ms, delay: 500.ms),
            ),
            SingleChildScrollView(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 290),
                  child: Column(
                    children: [
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
                        height: 40,
                      ),
                      Text(
                        "Login to Start",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "Or sign-Up if you're new here! ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                TextFields(
                                    height: 48.0,
                                    width: 310,
                                    controller: emailcontroller,
                                    hint: "Email",
                                    obstext: false),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFields(
                                    height: 48.0,
                                    width: 310,
                                    controller: passwordcontroller,
                                    hint: "Password",
                                    obstext: true),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ForgotPass();
                                }));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        color: Color.fromARGB(
                                            255, 105, 105, 105))),
                              ),
                            ),
                            //const SignUserIn()
                            const SizedBox(
                              height: 40,
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
                                  return signuserin();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 12, 12, 12),
                                  minimumSize: const Size(160, 50),
                                ),
                                child: Text(
                                  "LOG IN",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
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
                                    "Not a Member? ",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                  ),
                                  GestureDetector(
                                    onTap: widget.onTap,
                                    child: Text(
                                      "Register Now",
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
