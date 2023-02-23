// ignore_for_file: camel_case_types

import 'package:climate_care/login_quiz/index_dots.dart';
import 'package:flutter/material.dart';

import 'package:climate_care/login_quiz/quiz_design.dart';
import 'package:climate_care/home.dart';
import 'package:climate_care/login_quiz/progressbar.dart';

class logQuiz extends StatefulWidget {
  static const routeName = "quiz";
  const logQuiz({super.key});

  @override
  State<logQuiz> createState() => _logQuizState();
}

class _logQuizState extends State<logQuiz> {
  var _questionindex = 0;
  double finalscore = 0.0;
  double _dotindex = 0.0;
  var _progressindex = 0.0;
  final _questions = const [
    {
      'questionText1': 'What is your average monthly ',
      'questionText2': 'Electric Bill',
      'questionText3': '?',
      'answers': [
        {'text': '500-3000 PKR', 'score': 1500},
        {'text': '3000-10000 PKR', 'score': 5700},
        {'text': '10,000+', 'score': 18000},
      ],
      'lastbutton': [
        {'textn': 'Zero', 'score': 0}
      ],
    },
    {
      'questionText1': 'What is your average monthly ',
      'questionText2': 'Gas Bill',
      'questionText3': '?',
      'answers': [
        {'text': '300-1000 PKR ', 'score': 750},
        {'text': '1000-5000 PKR', 'score': 2500},
        {'text': '5000+', 'score': 7500},
      ],
      'lastbutton': [
        {'textn': 'Zero', 'score': 0}
      ],
    },
    {
      'questionText1': 'How many Km do you ',
      'questionText2': 'Drive',
      'questionText3': 'in a year?',
      'answers': [
        {'text': '1000-5000 Km', 'score': 2500},
        {'text': '5000-10000 Km', 'score': 7500},
        {'text': '10000+ ', 'score': 18000},
      ],
      'lastbutton': [
        {'textn': 'Zero', 'score': 0}
      ],
    },
    {
      'questionText1': 'How many ',
      'questionText2': 'Flights',
      'questionText3': 'have you taken last year?',
      'answers': [
        {'text': 'Less than 5', 'score': 4},
        {'text': 'Less than 10', 'score': 12},
        {'text': 'More than 15', 'score': 18},
      ],
      'lastbutton': [
        {'textn': 'None', 'score': 0}
      ],
    },
    {
      'questionText1': 'Do you ',
      'questionText2': 'Recycle',
      'questionText3': ' Paper(i.e. Newspaper)?',
      'answers': [
        {'text': 'Yes', 'score': 0},
      ],
      'lastbutton': [
        {'textn': 'No', 'score': 184}
      ],
    },
    {
      'questionText1': 'Do you ',
      'questionText2': 'Recycle',
      'questionText3': 'aluminumor or tin?',
      'answers': [
        {'text': 'Yes', 'score': 0},
      ],
      'lastbutton': [
        {'textn': 'No', 'score': 166}
      ],
    },
  ];

  void _answerQuestion(var score) {
    setState(() {
      _questionindex++;
      if (_dotindex < _questions.length) {
        _dotindex++;
      }
      _progressindex = _progressindex + 0.1428571428571429;
    });

    if (_questionindex <= 2) {
      score = score / 250;
      score = score * 105;
      finalscore = finalscore + score;
    }
    if (_questionindex == 3) {
      score = score / 1.609344;
      score = score * 0.79;
      finalscore += score;
    }
    if (_questionindex == 4) {
      score = score * 1100;
      finalscore += score;
    }
    if (_questionindex <= 7 && _questionindex > 4) {
      finalscore += score;
    }
    print(finalscore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //height: MediaQuery.of(context).size.height,
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
                  indexDots(_dotindex, _questions.length),
                ],
              )
            : const Home(),
      ),
    );
  }

  // Widget navigate(double em) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => Home(
  //               emissions: em,
  //             )),
  //   );
  //   return Container();
  // }
}
