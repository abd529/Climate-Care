import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'onbording.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      duration: 3000,
      backgroundColor: Theme.of(context).primaryColor,
      splash: Container(
          height: size.height / 3,
          width: size.height / 3,
          child: Image.asset("assets/logo.png")),
      splashIconSize: 500,
      nextScreen: Onbording(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
