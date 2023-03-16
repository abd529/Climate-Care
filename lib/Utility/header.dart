import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  const Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 250,
          child: Text(
            text,
            softWrap: true,
          ),
        ),
        SizedBox(
            height: 80, width: 80, child: Image.asset("assets/cli-matee.png"))
      ],
    );
  }
}
