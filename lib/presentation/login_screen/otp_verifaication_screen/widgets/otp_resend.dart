import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/login_bloc/login_bloc.dart';
import 'package:totalx/application/login_bloc/login_event.dart';
import 'package:totalx/application/login_bloc/login_state.dart';
import 'package:totalx/presentation/common/font_theme.dart';

class OtpResend extends StatelessWidget {
  const OtpResend({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final loginCont = context.read<LoginBloc>();
            loginCont.timer != 0
                ? loginCont.add(OtpTimerRunningEvent())
                : loginCont.add(OtpTimerFinishedEvent());
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    loginCont.isTimerFinished
                        ? const SizedBox()
                        : Text(
                            "${loginCont.timer.toString()} Sec",
                            style: FontTheme.timerStyle,
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(children: [
                      const Text("Didn't Get OTP? "),
                      loginCont.isTimerFinished
                          ? TextButton(
                              onPressed: () {
                                loginCont.add(ResendOtpClickedEvent());
                              },
                              child: Text(
                                "Resend",
                                style: FontTheme.resend,
                              ),
                            )
                          : const TextButton(
                              onPressed: null,
                              child: Text("Resend"),
                            )
                    ]),
                  ],
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
