// ignore_for_file: library_private_types_in_public_api

import 'package:climate_care/login_screens/lsoption.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'content_model.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      Text(
                        contents[i].title,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 300,
                        child: Text(
                          contents[i].discription,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 105, 105, 105),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).primaryColor,
                ),
                height: 53,
                margin: const EdgeInsets.only(top: 40, bottom: 45, right: 30),
                width: 53,
                child: TextButton(
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Option(),
                        ),
                      );
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 120),
                      curve: Curves.bounceIn,
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: const <Widget>[
                      Align(
                        alignment: Alignment(-30, 0),
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
