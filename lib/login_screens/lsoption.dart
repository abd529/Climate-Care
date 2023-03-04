import 'package:climate_care/login_screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'login_screen.dart';

class Option extends StatelessWidget {
  const Option({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.only(top: size.height / 4),
            child: Image.asset('assets/logo.png'),
          ),
          Container(
            width: size.width / 2,
            height: 60,
            margin: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Signup.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Create An Account',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                ),
              ),
            ),
          ),
          //const Spacer(),
          Container(
            width: size.width / 2,
            height: 50,
            margin: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
