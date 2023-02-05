import 'package:flutter/material.dart';

import 'lastbutton.dart';
import 'package:climate_care/login_quiz/question.dart';
import 'package:climate_care/login_quiz/answer.dart';

class quizDesign extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  quizDesign({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          questions[questionIndex]['questionText1'] as String,
          questions[questionIndex]['questionText2'] as String,
          questions[questionIndex]['questionText3'] as String,
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(), answer['text'] as String);
        }).toList(),
        ...(questions[questionIndex]['lastbutton'] as List<Map<String, Object>>)
            .map((answer) {
          return lastButton(() => answerQuestion(), answer['textn'] as String);
        }).toList(),
        
      ],
    );
  }
}
