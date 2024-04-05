import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/login_bloc/login_bloc.dart';
import 'package:totalx/presentation/common/custom_text_field.dart';
import 'package:totalx/presentation/common/font_theme.dart';

class LoginField extends StatelessWidget {
  const LoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Text(
              "Enter Phone number",
              style: FontTheme.heading,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          hint: "Enter phone number",
          cont: BlocProvider.of<LoginBloc>(context).phoneCont,
          hintStyle: FontTheme.hint,
          keyboard: TextInputType.number,
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(
                text: "By Continuing, I agree to TotalX’s ",
                style: FontTheme.privacy,
                children: [
              TextSpan(
                  text: "Terms and condition ",
                  style: FontTheme.termsAndCondition),
              TextSpan(
                  text: " & ",
                  style: TextStyle(color: Colors.black.withOpacity(0.7))),
              TextSpan(
                  text: "privacy policy", style: FontTheme.termsAndCondition),
            ]))
      ],
    );
  }
}
