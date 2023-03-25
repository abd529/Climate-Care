// ignore_for_file: avoid_print

import 'package:climate_care/Utility/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../Utility/back_button.dart';

class EnergyCalculator extends StatefulWidget {
  static const routeName = "energy-screen";
  const EnergyCalculator({super.key});

  @override
  State<EnergyCalculator> createState() => _EnergyCalculatorState();
}

class _EnergyCalculatorState extends State<EnergyCalculator> {
  int index = 0;
  final _formKey = GlobalKey<FormState>();
  int totalHours = 0;
  int totalUsage = 0;
  bool textValue = false;
  TextEditingController devName1 = TextEditingController();
  TextEditingController devUsage1 = TextEditingController();
  TextEditingController devHours1 = TextEditingController();

  TextEditingController devName2 = TextEditingController();
  TextEditingController devUsage2 = TextEditingController();
  TextEditingController devHours2 = TextEditingController();

  TextEditingController devName3 = TextEditingController();
  TextEditingController devUsage3 = TextEditingController();
  TextEditingController devHours3 = TextEditingController();

  TextEditingController devName4 = TextEditingController();
  TextEditingController devUsage4 = TextEditingController();
  TextEditingController devHours4 = TextEditingController();

  TextEditingController devName5 = TextEditingController();
  TextEditingController devUsage5 = TextEditingController();
  TextEditingController devHours5 = TextEditingController();

  void submit() {
    if (_formKey.currentState!.validate()) {
      if (devHours1.text.isNotEmpty & devUsage1.text.isNotEmpty) {
        setState(() {
          totalHours = totalHours + int.parse(devHours1.text);
          totalUsage = totalUsage + int.parse(devUsage1.text);
          devHours1.clear();
          devUsage1.clear();
          devName1.clear();
          textValue = true;
        });
      }
      if (devHours2.text.isNotEmpty & devUsage2.text.isNotEmpty) {
        setState(() {
          totalHours = totalHours + int.parse(devHours2.text);
          totalUsage = totalUsage + int.parse(devUsage2.text);
          devHours2.clear();
          devUsage2.clear();
          devName2.clear();
          textValue = true;
        });
      }
      if (devHours3.text.isNotEmpty & devUsage3.text.isNotEmpty) {
        setState(() {
          totalHours = totalHours + int.parse(devHours3.text);
          totalUsage = totalUsage + int.parse(devUsage3.text);
          devHours3.clear();
          devUsage3.clear();
          devName3.clear();
          textValue = true;
        });
      }
      if (devHours4.text.isNotEmpty & devUsage4.text.isNotEmpty) {
        setState(() {
          totalHours = totalHours + int.parse(devHours4.text);
          totalUsage = totalUsage + int.parse(devUsage4.text);
          devHours4.clear();
          devUsage4.clear();
          devName4.clear();
          textValue = true;
        });
      }
      if (devHours5.text.isNotEmpty & devUsage5.text.isNotEmpty) {
        setState(() {
          totalHours = totalHours + int.parse(devHours5.text);
          totalUsage = totalUsage + int.parse(devUsage5.text);
          devHours5.clear();
          devUsage5.clear();
          devName5.clear();
          textValue = true;
        });
      }

      print("yey");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0), child: MyBackButton()),
              const Text(
                "Energy Conspumtion Reducer",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Header(
            "Add your device info and evaluate your enrgy consumption",
            fontSize: 18,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  if (index == 0) ...[
                    devDetail(devName1, devUsage1, devHours1)
                  ] else if (index == 1) ...[
                    devDetail(devName1, devUsage1, devHours1),
                    devDetail(devName2, devUsage2, devHours2),
                  ] else if (index == 2) ...[
                    devDetail(devName1, devUsage1, devHours1),
                    devDetail(devName2, devUsage2, devHours2),
                    devDetail(devName3, devUsage3, devHours3),
                  ] else if (index == 3) ...[
                    devDetail(devName1, devUsage1, devHours1),
                    devDetail(devName2, devUsage2, devHours2),
                    devDetail(devName3, devUsage3, devHours3),
                    devDetail(devName4, devUsage4, devHours4),
                  ] else if (index == 4) ...[
                    devDetail(devName1, devUsage1, devHours1),
                    devDetail(devName2, devUsage2, devHours2),
                    devDetail(devName3, devUsage3, devHours3),
                    devDetail(devName4, devUsage4, devHours4),
                    devDetail(devName5, devUsage5, devHours5),
                  ],
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        if (index < 4) {
                          setState(() {
                            index++;
                          });
                        }
                        print(index);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text(
                        "+ Add",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        if (index > 0) {
                          setState(() {
                            index--;
                          });
                          print(index);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.red),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            width: 120,
            child: ElevatedButton(
                onPressed: () {
                  submit();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    backgroundColor: Colors.green),
                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 17),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          EnergyDetails(
            usage: totalUsage,
            hours: totalHours,
            showData: textValue,
          ),
        ]),
      )),
    );
  }

  Widget devDetail(TextEditingController devNameCon,
      TextEditingController devUsageCon, TextEditingController devHoursCon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Device Info",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: devNameCon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required!";
                  }
                  return null;
                },
                decoration: feildStyle("Device Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: devUsageCon,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required!";
                        } else if (!isNumeric(value)) {
                          return "Only Numbers";
                        }
                        return null;
                      },
                      decoration: feildStyle("Device Wattage"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: devHoursCon,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required!";
                        } else if (!isNumeric(value)) {
                          return "Only Numbers";
                        }
                        return null;
                      },
                      decoration: feildStyle("Hours Used"),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Example: A 125-watt television used three hours per day",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration feildStyle(String hintText) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.green),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
        ));
  }
}

class EnergyDetails extends StatefulWidget {
  final int usage;
  final int hours;
  final bool showData;
  const EnergyDetails(
      {super.key,
      required this.hours,
      required this.usage,
      this.showData = false});

  @override
  State<EnergyDetails> createState() => _EnergyDetailsState();
}

class _EnergyDetailsState extends State<EnergyDetails> {
  static const int avgUsage = 886;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  double reduced = 0;
  int coins = 0;
  int wattsPerDay() {
    final int perDay = widget.usage * widget.hours;
    return perDay;
  }

  double convertToKilo(int perDay) {
    double kiloPerDay = perDay / 1000;
    return kiloPerDay;
  }

  double monthlyUsage(double dailyUsage) {
    double monthly = dailyUsage * 30;
    return monthly;
  }

  void getReward() async {
    final docSnapshotRed = await FirebaseFirestore.instance
        .collection("Reduced Emission")
        .doc("$userId Reduced")
        .get();
    if (docSnapshotRed.exists) {
      Map<String, dynamic>? data = docSnapshotRed.data();
      var value = data?['reduced'];
      print(value);
      setState(() {
        reduced = value;
      });
    }
    final docSnapshotCoin = await FirebaseFirestore.instance
        .collection("Green Coins")
        .doc("$userId Coins")
        .get();
    if (docSnapshotCoin.exists) {
      Map<String, dynamic>? data = docSnapshotCoin.data();
      var value = data?['coins'];
      print(value);
      setState(() {
        coins = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int perDay = wattsPerDay();
    double kiloPerDay = convertToKilo(perDay);
    double monthlyUse = monthlyUsage(kiloPerDay);
    //double savedEn = avgUsage - monthlyUse;
    print("monthly: $monthlyUse");
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Center(
            child: widget.showData == false
                ? const Text("Submit the device's info")
                : monthlyUse > avgUsage
                    ? Text(
                        "Your monthly average energy usage is $monthlyUse kWh which is higher than the average energy consumption (886 kWh).\n We'll suggest you to start working on your energy saving and try again later.",
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Yahooo!, your monthly average energy usage is $monthlyUse kWh which is less than the average energy consumption (886 kWh).",
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: () {
                                getReward();
                                FirebaseFirestore.instance
                                    .collection("Reduced Emission")
                                    .doc("$userId Reduced")
                                    .update({
                                  "reduced": reduced + (monthlyUse * 0.5)
                                });
                                FirebaseFirestore.instance
                                    .collection("Green Coins")
                                    .doc("$userId Coins")
                                    .update({"coins": coins + 50});
                                FirebaseFirestore.instance
                                    .collection("EmissionLevel")
                                    .doc(userId)
                                    .update({"energy": true});
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor:
                                              Colors.lightGreen[100],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          title: Row(
                                            children: [
                                              const Text("Congratulations!"),
                                              SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image.asset(
                                                    "assets/cli-matee.png"),
                                              )
                                            ],
                                          ),
                                          content: Text(
                                            "You just reduced approximately \n${monthlyUse * 0.5} kg CO2 Emissions. \nAnd you earned 50 Green Coins",
                                            softWrap: true,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ));
                              },
                              child: const Text("Get Reward"))
                        ],
                      )),
      ),
    );
  }
}
