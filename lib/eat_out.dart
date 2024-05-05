import 'package:flutter/material.dart';

class EatOut extends StatefulWidget {
  const EatOut({super.key});

  @override
  State<EatOut> createState() => _EatOutState();
}

class _EatOutState extends State<EatOut> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("eat out"),
      ),
    );
  }
}
