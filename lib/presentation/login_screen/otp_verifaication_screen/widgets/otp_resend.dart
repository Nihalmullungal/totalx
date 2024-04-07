import 'dart:developer';

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
    final loginCont = BlocProvider.of<LoginBloc>(context);
    return Column(
      children: [
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            !loginCont.isTimerFinished
                ? loginCont.add(OtpTimerRunningEvent(
                    timer: loginCont.timer, isResend: false))
                : log("------  state = $state");

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    state is OtpTimerFinishedState
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
