// ignore_for_file: camel_case_types, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'lastbutton.dart';
import 'package:climate_care/CO2%20Emission%20Calulator/question.dart';
import 'package:climate_care/CO2%20Emission%20Calulator/answer.dart';

class quizDesign extends StatelessWidget {
  final List<Map<String, Object>> questions;
  var questionIndex;
  final Function answerQuestion;

  quizDesign({
    super.key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Question(
            questions[questionIndex]['questionText1'] as String,
            questions[questionIndex]['questionText2'] as String,
            questions[questionIndex]['questionText3'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return Answer(() => answerQuestion(answer['score']),
                answer['text'] as String);
          }).toList(),
          ...(questions[questionIndex]['lastbutton']
                  as List<Map<String, Object>>)
              .map((answer) {
            return lastButton(() => answerQuestion(answer['score']),
                answer['textn'] as String);
          }).toList(),
        ],
      ),
    );
  }
}
