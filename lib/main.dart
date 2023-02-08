import 'package:climate_care/home.dart';
import 'package:climate_care/login_screens/login.dart';
import 'package:climate_care/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(71, 191, 83, 1.0),
        appBarTheme: AppBarTheme(backgroundColor: Colors.green, elevation: 0, titleTextStyle: GoogleFonts.poppins(fontSize: 18))
      ),
      home: Home(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        Home.routeName: (ctx)=> Home(),
      },
    );
  }
}
