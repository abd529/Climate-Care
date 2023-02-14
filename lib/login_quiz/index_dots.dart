// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class indexDots extends StatelessWidget {
  double dotindex;
  int qlength;

  indexDots(this.dotindex, this.qlength, {super.key});
  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: qlength,
      position: dotindex,
      decorator: DotsDecorator(
        color: const Color.fromARGB(255, 230, 230, 230),
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        spacing: const EdgeInsets.only(left: 15, right: 15, top: 40),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
