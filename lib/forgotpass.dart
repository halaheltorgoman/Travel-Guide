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
              backgroundColor: const Color.fromARGB(235, 249, 187, 3),
              content: Text(e.message.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        title: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 166, 7, 7),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Enter your Email to Reset Password:",
              style: TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          TextFields(
              controller: emailcontroller, hint: "Email", obstext: false),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: passreset,
            child: Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromARGB(181, 170, 0, 0),
                fixedSize: const Size(200, 55),
                foregroundColor: const Color.fromARGB(255, 238, 237, 237),
                side: const BorderSide(
                    width: 2, color: Color.fromARGB(255, 234, 234, 234))),
          ),
        ],
      ),
    );
  }
}
