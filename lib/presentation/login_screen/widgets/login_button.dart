import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/login_bloc/login_bloc.dart';
import 'package:totalx/application/login_bloc/login_event.dart';
import 'package:totalx/application/login_bloc/login_state.dart';
import 'package:totalx/presentation/common/custom_snackbar.dart';
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
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (contex, state) {
          if (state is GetOtpSentState) {
            customSnackBar(context, "OTP sent", true, false);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const OtpVerificationScreen()),
              (route) => false,
            );
          }
          if (state is SubmitOtpClickedState) {
            customSnackBar(context, "Login Succesfully", true, false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          }
          if (state is NumberNotValidState) {
            customSnackBar(context, "enter a valid phone number", false, false);
          } else if (state is WrongOtpClickedState) {
            customSnackBar(context, "wrong OTP", false, false);
          } else if (state is GetOtpFailedEvent) {
            customSnackBar(context, "failed to get OTP", false, false);
          }
        },
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ElevatedButton(
              onPressed: () async {
                isGetOtp
                    ? BlocProvider.of<LoginBloc>(context)
                                .phoneCont
                                .text
                                .trim()
                                .length ==
                            10
                        ? BlocProvider.of<LoginBloc>(context)
                            .add(GetOtpClickedEvent(isGetOtpPage: isGetOtp))
                        : BlocProvider.of<LoginBloc>(context)
                            .add(NumberNotValidEvent())
                    : BlocProvider.of<LoginBloc>(context)
                        .add(SubmitOtpClickedEvent());
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
              child: Text(
                submitText,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
