import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/login_bloc/login_bloc.dart';
import 'package:totalx/presentation/home_screen/home_screen.dart';
import 'package:totalx/presentation/login_screen/otp_verifaication_screen/otp_verifiaction_screen.dart';

class LoginButton extends StatelessWidget {
  final String submitText;
  final bool isGetOtp;
  const LoginButton(
      {super.key, required this.submitText, required this.isGetOtp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
          isGetOtp
              ? BlocProvider.of<LoginBloc>(context).phoneCont.text.length == 10
                  ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const OtpVerificationScreen()),
                      (route) => false)
                  : log("paali")
              : Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
        child: Text(
          submitText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
