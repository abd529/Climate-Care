// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'quiz_screen.dart';

class qBoard extends StatelessWidget {
  const qBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 100, left: 10, right: 10, bottom: 80),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: ('Are you from '),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontSize: 38),
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
                children: [
                  TextSpan(
                    text: ('Pakistan?'),
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 38),
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: 225,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const logQuiz(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Yes', style: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(
            width: 225,
            height: 50,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('No', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
