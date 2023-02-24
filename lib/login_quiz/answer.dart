// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  var selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      margin: const EdgeInsets.all(15),
      height: 40,
      child: ElevatedButton(
        onPressed: () => selectHandler(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(answerText, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
