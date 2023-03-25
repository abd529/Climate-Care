import 'package:flutter/material.dart';

import '../Utility/back_button.dart';

class ComingSoon extends StatelessWidget {
  static const routeName = "coming-soon";

  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyBackButton(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          const Center(
            child: Text(
              "Coming Soon!",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
