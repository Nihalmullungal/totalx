import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totalx/application/splash_cubit/splash_state.dart';
import 'package:totalx/presentation/common/appconstants.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(InitialSplashState()) {
    emit(LoadingSplashState());
    Timer(const Duration(seconds: 4), () async {
      final bool? result = await AppConstants.checkSharedPref();
      if (result == null || result == false) {
        emit(NotLoginSplashState());
      } else {
        emit(AlreadyLoginSplashState());
      }
    });
  }
}
