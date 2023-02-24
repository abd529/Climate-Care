// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class proBar extends StatelessWidget {
  var proindex = 0.0;
  final bool shadow;

  proBar(this.proindex, this.shadow, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: shadow == true
            ? [
                // BoxShadow(
                //   color: Colors.grey.withOpacity(0.5),
                //   spreadRadius: 0,
                //   blurRadius: 4,
                //   offset: Offset(0, 0), // changes position of shadow
                // ),
              ]
            : [],
      ),
      //margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
      child: LinearPercentIndicator(
        lineHeight: 20,
        percent: proindex,
        progressColor: Colors.green,
        backgroundColor: Colors.grey[200],
        barRadius: const Radius.circular(20),
      ),
    );
  }
}
