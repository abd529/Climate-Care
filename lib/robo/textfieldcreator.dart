import 'package:flutter/material.dart';

class TextFild extends StatelessWidget {
  const TextFild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            hintText: '#item',
            hintStyle: const TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}
