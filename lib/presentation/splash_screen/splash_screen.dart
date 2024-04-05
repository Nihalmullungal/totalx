import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:totalx/application/splash_cubit/splash_cubit.dart';
import 'package:totalx/application/splash_cubit/splash_state.dart';
import 'package:totalx/presentation/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is NotLoginSplashState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/loading.json", height: 50),
              const SizedBox(
                height: 5,
              ),
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText("Loading...",
                    speed: const Duration(milliseconds: 100))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
