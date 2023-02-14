// ignore_for_file: camel_case_types

import 'package:climate_care/login_quiz/index_dots.dart';
import 'package:flutter/material.dart';

import 'package:climate_care/login_quiz/quiz_design.dart';
import 'package:climate_care/home.dart';
import 'package:climate_care/login_quiz/progressbar.dart';

class logQuiz extends StatefulWidget {
  const logQuiz({super.key});

  @override
  State<logQuiz> createState() => _logQuizState();
}

class _logQuizState extends State<logQuiz> {
  var _questionindex = 0;
  double _dotindex = 0.0;
  var _progressindex = 0.0;
  final _questions = const [
    {
      'questionText1': 'How many miles did you ',
      'questionText2': 'drive',
      'questionText3': ' in the last year?',
      'answers': [
        {'text': 'Less than 5,000', 'score': 1},
        {'text': 'Between 5,000-10,0000', 'score': 1},
        {'text': 'More than 10,000', 'score': 1},
      ],
      'lastbutton': [
        {'textn': 'Zero', 'score': 1}
      ],
    },
    {
      'questionText1': 'How many ',
      'questionText2': 'Flights',
      'questionText3': ' have you taken in the last year?',
      'answers': [
        {'text': 'One to Two ', 'score': 1},
        {'text': 'Three To Five', 'score': 1},
        {'text': 'More than Five', 'score': 1},
      ],
      'lastbutton': [
        {'textn': 'Zero', 'score': 1}
      ],
    },
    {
      'questionText1': 'How many days per week do you eat ',
      'questionText2': 'Meat',
      'questionText3': ' ?',
      'answers': [
        {'text': 'One to Three ', 'score': 1},
        {'text': 'Five to Six', 'score': 1},
        {'text': 'Everday', 'score': 1},
      ],
      'lastbutton': [
        {'textn': 'Zero', 'score': 1}
      ],
    },
    {
      'questionText1': 'How is your ',
      'questionText2': 'Electercity',
      'questionText3': ' powered?',
      'answers': [
        {'text': '100% Clean', 'score': 1},
        {'text': '50% Clean', 'score': 1},
        {'text': 'Not Clean ', 'score': 1},
      ],
      'lastbutton': [
        {'textn': 'Use Local average', 'score': 1}
      ],
    },
  ];

  void _answerQuestion() {
    setState(() {
      _questionindex++;
      if (_dotindex < _questions.length) {
        _dotindex++;
      }
      _progressindex = _progressindex + 0.25;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _questionindex < _questions.length
          ? Column(
              children: [
                proBar(_progressindex),
                quizDesign(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionindex,
                  questions: _questions,
                ),
                indexDots(_dotindex, _questions.length)
              ],
            )
          : const Home(),
    );
  }
}
