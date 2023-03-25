// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  String routeName = "";
  MyBackButton({this.routeName = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(15)),
        child: IconButton(
            onPressed: () {
              if (routeName == "") {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    routeName, (Route<dynamic> route) => false);
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )));
  }
}
