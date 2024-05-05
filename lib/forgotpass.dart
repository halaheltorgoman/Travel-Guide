import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelguide/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final emailcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  Future passreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Color.fromARGB(235, 249, 187, 3),
              content: Text("Password Reset Link Sent!",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color.fromARGB(235, 249, 3, 3),
              content: Text(e.message.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            );
          });
    }
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
              height: 240,
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
            SingleChildScrollView(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 290),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Enter Your Email to Reset Your Password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 21,
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
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
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
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.4),
                                        blurRadius: 4,
                                        offset: const Offset(0, 8),
                                      )
                                    ]),
                                child: ElevatedButton(
                                  onPressed: passreset,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 12, 12, 12),
                                    minimumSize: const Size(160, 50),
                                  ),
                                  child: Text(
                                    "RESET PASSWORD",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
