import 'package:flutter/material.dart';

class lastButton extends StatelessWidget {
  var buttonfun;
  final String buttontext;

  lastButton(this.buttonfun, this.buttontext);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.all(15),
      height: 50,
      child: ElevatedButton(
        onPressed: buttonfun,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
         ),
        ),
        child: Text(buttontext, 
          style: 
             TextStyle(fontSize: 12, color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
