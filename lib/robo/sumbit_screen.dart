import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'textfieldcreator.dart';

class SumbitScreen extends StatefulWidget {
  const SumbitScreen({super.key});

  @override
  State<SumbitScreen> createState() => _SumbitScreenState();
}

class _SumbitScreenState extends State<SumbitScreen> {
  int creator = 0;
  bool fild_no_check = false;
  void addbutton() {
    setState(() {
      if (creator < 3) {
        creator++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Waste Reduction',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (creator == 0) ...[
            const TextFild()
          ] else if (creator == 1) ...[
            const TextFild(),
            const TextFild(),
          ] else if (creator == 2) ...[
            const TextFild(),
            const TextFild(),
            const TextFild(),
          ] else if (creator == 3) ...[
            const TextFild(),
            const TextFild(),
            const TextFild(),
            const TextFild(),
          ],
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: addbutton,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                '+ Add more',
                style: TextStyle(color: Colors.black, fontSize: 11),
              ),
            ),
          ),
          Container(
            width: 130,
            height: 45,
            margin: const EdgeInsets.all(30),
            child: ElevatedButton(
              onPressed: () => const TextFild(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
              ),
              child: const Text('Sumbit'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green.shade100,
            ),
            child: const Text(
              'Response \n its not responsive yet...',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
