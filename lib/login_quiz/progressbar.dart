// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class proBar extends StatelessWidget {
  var proindex = 0.0;

  proBar(this.proindex, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
      child: LinearPercentIndicator(
        lineHeight: 20,
        percent: proindex,
        progressColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        barRadius: const Radius.circular(20),
      ),
    );
  }
}
