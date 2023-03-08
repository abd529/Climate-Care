// ignore_for_file: unused_import
import 'package:climate_care/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:climate_care/home.dart';
import 'package:climate_care/onboarding/splash.dart';
import 'Screens/settings.dart';
import 'CO2 Emission Calulator/quiz_screen.dart';
import 'Authentication/login_screen.dart';
import 'Authentication/lsoption.dart';
import 'Authentication/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
      home:
          const Home(), //change this to Home screen the score value is in quiz_screen.dart>>finalscore
      routes: {
        Signup.routeName: (ctx) => const Signup(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        logQuiz.routeName: (ctx) => const logQuiz(),
        Option.routeName: (ctx) => const Option(),
      },
    );
  }
}
