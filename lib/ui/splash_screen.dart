import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xff6b9dfc),
      duration: 3000,
      splash: Center(
        child: LottieBuilder.asset(
          'assets/Animation.json',
          width: context.width * 0.3,
          height: context.height * 0.3,
        ),
      ),
      nextScreen: const HomePage(),
    );
  }
}
