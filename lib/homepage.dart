import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  void signuserout() {
    FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 176, 30),
        actions: [
          IconButton(onPressed: signuserout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "Lottie/uwu.gif",
            width: 200,
          )),
          Text("logged in as :" + user!.email!)
        ],
      ),
    );
  }
}
