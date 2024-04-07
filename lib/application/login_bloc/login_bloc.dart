import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:totalx/application/login_bloc/login_event.dart';
import 'package:totalx/application/login_bloc/login_state.dart';
import 'package:totalx/presentation/common/appconstants.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState()) {
    on<OtpTimerRunningEvent>((event, emit) async {
      if (event.isResend) {
        add(GetOtpSentEvent());
      }
      await Future.delayed(const Duration(seconds: 1), () {
        timer = event.timer - 1;

        if (timer > 0) {
          isTimerFinished = false;
          emit(OtpRunningState());
        } else {
          add(OtpTimerFinishedEvent());
        }
      });
    });
    on<OtpTimerFinishedEvent>((event, emit) {
      isTimerFinished = true;
      timer = 0;
      emit(OtpTimerFinishedState());
    });
    on<ResendOtpClickedEvent>((event, emit) {
      emit(ResendOtpClickedState());
      add(GetOtpClickedEvent(isGetOtpPage: false));
    });
    on<GetOtpFailedEvent>((event, emit) => emit(GetOtpfailedState()));

    ///////////////// get otp event ////////////////

    on<GetOtpClickedEvent>((event, emit) async {
      emit(LoginLoadingState());

      await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (AuthCredential phoneAuthCredential) async {},
        codeSent: (verificationId, forceResendingToken) {
          result = verificationId;
          event.isGetOtpPage
              ? add(GetOtpSentEvent())
              : add(OtpTimerRunningEvent(timer: 60, isResend: true));
        },
        verificationFailed: (error) async {
          add(GetOtpFailedEvent());
          result = "failed";
        },
        codeAutoRetrievalTimeout: (verificationId) {
          add(GetOtpFailedEvent());
          result = verificationId;
        },
        timeout: const Duration(seconds: 60),
        phoneNumber: "+91${phoneCont.text}",
      );
    });

////////////////// verify otp event ///////////////

    on<SubmitOtpClickedEvent>((event, emit) async {
      emit(LoginLoadingState());
      await otpVerification();
      await Future.delayed(const Duration(seconds: 5));
    });

///////////// to navigate verifaction page ////////////////

    on<GetOtpSentEvent>((event, emit) => emit(GetOtpSentState()));
///////////// to navigate verifaction page ////////////////

    on<SubmitOtpClickedSuccessEvent>(
        (event, emit) => emit(SubmitOtpClickedState()));

//////////////////////// to throw not valid number error ////////////////

    on<NumberNotValidEvent>((event, emit) => emit(NumberNotValidState()));

    //////////////////////// to throw not valid number error ////////////////

    on<WrongOtpClickedEvent>((event, emit) => emit(WrongOtpClickedState()));

    //////////////////////////////// resend otp event /////////////////////
    on<ResendOtpSentEvent>((event, emit) => emit(ResendOtpSentState()));
  }

  //////////////// variable //////////////////////

  String result = "failed";
  OtpFieldController otpController = OtpFieldController();
  TextEditingController phoneCont = TextEditingController();
  int otp = 0;
  int timer = 60;
  bool isTimerFinished = false;

  //////////////////////// phone verification////////////////

  Future<void> otpVerification() async {
    try {
      final response = PhoneAuthProvider.credential(
          verificationId: result, smsCode: otp.toString());

      await FirebaseAuth.instance.signInWithCredential(response);
      add(SubmitOtpClickedSuccessEvent());
      AppConstants.setSharedPre(true);
      phoneCont.clear();
      timer = 60;
      isTimerFinished = false;
    } catch (e) {
      log("paaali$e");
      add(WrongOtpClickedEvent());
    }

    return;
  }
}
