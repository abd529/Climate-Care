// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;

  const CountdownTimer({super.key, required this.targetDate});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration = widget.targetDate.difference(DateTime.now());
      });
    });
  }

  Map<String, dynamic> _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String days = twoDigits(duration.inDays);
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return {"days": days, "hours": hours, "min": minutes, "sec": seconds};
  }

  @override
  Widget build(BuildContext context) {
    String days = _formatTime(_duration)["days"];
    String hours = _formatTime(_duration)["hours"];
    String min = _formatTime(_duration)["min"];
    String sec = _formatTime(_duration)["sec"];

    if (_duration.inDays <= 0) {
      days = "00";
    }
    if (_duration.inHours <= 0) {
      hours = "00";
    }
    if (_duration.inMinutes <= 0) {
      min = "00";
    }
    if (_duration.inSeconds <= 0) {
      sec = "00";
    }

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          colNum("Days", days),
          const SizedBox(
            width: 10,
          ),
          cols(),
          const SizedBox(
            width: 10,
          ),
          colNum("Hours", hours),
          const SizedBox(
            width: 10,
          ),
          cols(),
          const SizedBox(
            width: 10,
          ),
          colNum("Minutes", min),
          const SizedBox(
            width: 10,
          ),
          cols(),
          const SizedBox(
            width: 10,
          ),
          colNum("Seconds", sec)
        ],
      ),
    );
  }

  Padding cols() {
    return const Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        ":",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  Column colNum(String text, String days) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.green),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
          child: Center(
            child: Text(
              days,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
