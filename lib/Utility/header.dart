import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  const Header(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            text,
            softWrap: true,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
        SizedBox(
            height: 80, width: 80, child: Image.asset("assets/cli-matee.png"))
      ],
    );
  }
}
