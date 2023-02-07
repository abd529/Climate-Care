import 'package:flutter/material.dart';

import 'login.dart';

class Option extends StatelessWidget {
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
          // Container(
          //   width: size.width / 2,
          //   height: 60,
          //   margin: const EdgeInsets.all(20.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(LoginScreen.routeName);
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: const Text(
          //       'Login',
          //       style: TextStyle(
          //         color: Color.fromRGBO(0, 0, 0, 1.0),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 50,),
          Container(
            width: size.width / 2,
            height: 60,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
