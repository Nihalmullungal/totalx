import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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
    on<GetOtpClickedEvent>((event, emit) async {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (AuthCredential phoneAuthCredential) async {},
        codeSent: (verificationId, forceResendingToken) {
          result = verificationId;
          add(GetOtpSentEvent());
        },
        verificationFailed: (error) {
          emit(GetOtpfailedState());
          result = "failed";
        },
        codeAutoRetrievalTimeout: (verificationId) {
          result = verificationId;
        },
        timeout: const Duration(seconds: 60),
        phoneNumber: "+919846298210",
      );
    });
    on<SubmitOtpClickedEvent>((event, emit) async {
      emit(LoginLoadingState());
      await otpVerification();
      await Future.delayed(const Duration(seconds: 5));
      emit(SubmitOtpClickedState());
    });
    on<GetOtpSentEvent>((event, emit) => emit(GetOtpSentState()));
    on<NumberNotValidEvent>((event, emit) => emit(NumberNotValidState()));
  }
  String result = "failed";
  OtpFieldController otpController = OtpFieldController();
  TextEditingController phoneCont = TextEditingController();
  int otp = 0;
  int timer = 60;
  bool isTimerFinished = false;

  //////////////////////// phone verification////////////////

  Future<void> otpVerification() async {
    log(otp.toString());
    log(result);
    final response = PhoneAuthProvider.credential(
        verificationId: result, smsCode: otp.toString());

    await FirebaseAuth.instance.signInWithCredential(response);
    return;
  }

//////////////////////////// otp checking //////////////////////

  Future<void> otpchecking() async {}
}
