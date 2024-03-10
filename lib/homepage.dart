import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void SignUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 128, 166, 197),
        actions: [IconButton(onPressed: SignUserOut, icon: Icon(Icons.logout))],
      ),
      body: Center(child: Text(" yormama")),
    );
  }
}
