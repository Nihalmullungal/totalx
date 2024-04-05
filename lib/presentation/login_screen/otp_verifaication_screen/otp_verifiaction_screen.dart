import 'package:flutter/material.dart';
import 'package:totalx/presentation/login_screen/otp_verifaication_screen/widgets/otp_field.dart';
import 'package:totalx/presentation/login_screen/otp_verifaication_screen/widgets/otp_resend.dart';
import 'package:totalx/presentation/login_screen/otp_verifaication_screen/widgets/otp_screen_text.dart';
import 'package:totalx/presentation/login_screen/widgets/login_button.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/Group.png")),
            const OtpScreenText(),
            const OtpField(),
            const OtpResend(),
            const LoginButton(
              submitText: "Verify",
              isGetOtp: false,
            ),
          ],
        ),
      ),
    );
  }
}
