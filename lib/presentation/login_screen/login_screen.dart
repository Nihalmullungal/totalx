import 'package:flutter/material.dart';
import 'package:totalx/presentation/login_screen/widgets/login_button.dart';
import 'package:totalx/presentation/login_screen/widgets/login_field.dart';
import 'package:totalx/presentation/login_screen/widgets/login_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            LoginImage(),
            LoginField(),
            LoginButton(
              submitText: "Get OTP",
              isGetOtp: true,
            ),
          ],
        ),
      ),
    );
  }
}
