// ignore_for_file: unused_import
import 'package:climate_care/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:climate_care/home.dart';
import 'package:climate_care/login_screens/login.dart';
import 'package:climate_care/onboarding/splash.dart';
import 'login_quiz/quiz_screen.dart';
import 'robo/robo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(71, 191, 83, 1),
          textTheme: TextTheme(bodyLarge: GoogleFonts.poppins()),
          fontFamily: GoogleFonts.poppins().fontFamily,
          appBarTheme: AppBarTheme(
              backgroundColor: const Color.fromRGBO(71, 191, 83, 1.0),
              elevation: 0,
              titleTextStyle: GoogleFonts.poppins(fontSize: 18))),
      home: const Home(
          emissions:
              9000), //change this to Home screen the score value is in quiz_screen.dart>>finalscore
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        logQuiz.routeName: (ctx) => const logQuiz(),
      },
    );
  }
}
