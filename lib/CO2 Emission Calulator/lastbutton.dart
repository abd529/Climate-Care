// ignore_for_file: must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class lastButton extends StatelessWidget {
  var buttonfun;
  final String buttontext;

  lastButton(this.buttonfun, this.buttontext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      margin: const EdgeInsets.all(15),
      height: 40,
      child: ElevatedButton(
        onPressed: buttonfun,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(buttontext,
            style: const TextStyle(fontSize: 12, color: Colors.white)),
      ),
    );
  }
}
