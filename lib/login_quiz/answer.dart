import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  var selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(15),
      height: 50,
      child: ElevatedButton(
        onPressed: selectHandler,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
         ),
        ),
        child: Text(answerText, 
          style: 
            const TextStyle(fontSize: 12)),
      ),
    );
  }
}
