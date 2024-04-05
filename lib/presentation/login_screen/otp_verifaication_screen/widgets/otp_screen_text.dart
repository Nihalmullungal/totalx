import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/login_bloc/login_bloc.dart';
import 'package:totalx/presentation/common/font_theme.dart';

class OtpScreenText extends StatelessWidget {
  const OtpScreenText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          "OTP verification",
          style: FontTheme.subHeading,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Enter the verification code we just sent to your number +91 ********${BlocProvider.of<LoginBloc>(context).phoneCont.text.substring(
                8,
              )}",
          style: FontTheme.hint,
        ),
      ],
    );
  }
}
