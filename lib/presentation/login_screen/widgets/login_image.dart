import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(child: Image.asset("assets/images/OBJECTS.png")));
  }
}
