import 'package:climate_care/Authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class Option extends StatelessWidget {
  static const routeName = "option-screen";
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
            margin: EdgeInsets.only(
              top: size.height / 4,
              bottom: 25,
            ),
            child: Image.asset('assets/logo.png'),
          ),
          Container(
            width: size.width / 1.75,
            height: 50,
            margin: const EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Signup.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          //const Spacer(),
          SizedBox(
            width: size.width / 1.75,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
