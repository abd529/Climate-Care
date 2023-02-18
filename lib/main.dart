// ignore_for_file: unused_import

import 'package:climate_care/home.dart';
import 'package:climate_care/login_screens/login.dart';
import 'package:climate_care/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(71, 191, 83, 1.0),
        textTheme: TextTheme(bodyLarge: GoogleFonts.poppins()),
        appBarTheme: AppBarTheme(backgroundColor: Colors.green, elevation: 0, titleTextStyle: GoogleFonts.poppins(fontSize: 18))
      ),
      home:  const Home(),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        Home.routeName: (ctx) => const Home(),
      },
    );
  }
}
