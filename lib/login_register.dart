import 'package:travelguide/loginpage.dart';
import 'package:travelguide/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showlogin = true;
  void togglepages() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return LoginPage(
        onTap: togglepages,
      );
    } else {
      return RegisterUser(
        onTap: togglepages,
      );
    }
  }
}
