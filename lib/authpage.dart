import 'package:firebase_auth/firebase_auth.dart';

import 'package:travelguide/login_register.dart';

import 'package:flutter/material.dart';

import 'package:travelguide/visited_country.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return const VisitedCountry();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
