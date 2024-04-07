import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:totalx/application/login_bloc/login_bloc.dart';

class OtpField extends StatelessWidget {
  const OtpField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Center(
          child: OTPTextField(
            controller: BlocProvider.of<LoginBloc>(context).otpController,
            fieldWidth: 45,
            length: 6,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            width: MediaQuery.of(context).size.width,
            fieldStyle: FieldStyle.box,
            onChanged: (value) {},
            onCompleted: (value) {
              BlocProvider.of<LoginBloc>(context).otp = int.parse(value);
            },
          ),
        ),
      ],
    );
  }
}
