import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:totalx/application/login_bloc/login_event.dart';
import 'package:totalx/application/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<OtpTimerRunningEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      timer--;
      emit(OtpRunningState());
    });
    on<OtpTimerFinishedEvent>((event, emit) {
      isTimerFinished = true;
      emit(OtpTimerFinishedState());
    });
    on<ResendOtpClickedEvent>((event, emit) {
      isTimerFinished = false;
      timer = 60;
      emit(ResendOtpClickedState());
    });
  }
  OtpFieldController otpController = OtpFieldController();
  TextEditingController phoneCont = TextEditingController();
  int otp = 0;
  int timer = 60;
  bool isTimerFinished = false;
}
