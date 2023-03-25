// ignore_for_file: depend_on_referenced_packages, must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:climate_care/Screens/garden_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/plant.dart';
import '../Utility/header.dart';

class UpdatePlant extends StatefulWidget {
  Plant plant;
  UpdatePlant(this.plant, {super.key});

  @override
  State<UpdatePlant> createState() => _UpdatePlantState();
}

class _UpdatePlantState extends State<UpdatePlant> {
  DateTime date = DateTime.now();
  String status = "";
  final _formKey = GlobalKey<FormState>();
  final SingleValueDropDownController _statusController =
      SingleValueDropDownController();
  final TextEditingController _dateController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  double reduced = 0.0;
  double totalRe = 0.0;
  int coins = 0;

  void submit() async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection("User Plants")
          .doc("$userId Plants")
          .collection("Plants")
          .doc(widget.plant.plantId)
          .update({
        "plantStatus": _statusController.dropDownValue!.value,
        "date": date
      });
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
      FirebaseFirestore.instance
          .collection("Reduced Emission")
          .doc("$userId Reduced")
          .update({"reduced": reduced + 30});
      FirebaseFirestore.instance
          .collection("Green Coins")
          .doc("$userId Coins")
          .update({"coins": coins + 50});

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.lightGreen[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Row(
                  children: [
                    const Text("Congratulations!"),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/cli-matee.png"),
                    )
                  ],
                ),
                content: const Text(
                  "You updated your plant status and reduced approximately \n30kg CO2 Emissions. \nAnd you earned 50 Green Coins",
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const GardenScreen()),
                            (route) => false);
                      },
                      child: const Text("Jump to Garden"))
                ],
              ));
    }
  }

  Future<DateTime?> datePick(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      setState(() {
        date = pickedDate;
      });
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      setState(() {
        controller.text = formattedDate;
      });
      return DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    } else {
      print("Date is not selected");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header("Update ${widget.plant.nickName}'s status"),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () {
                            datePick(context, _dateController);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required!";
                            }
                            return null;
                          },
                          decoration: textFeildDecoration(
                              "Date for next Plant Status Update",
                              Icons.calendar_month_outlined),
                        ),
                        DropDownTextField(
                            clearIconProperty: IconProperty(
                                icon: Icons.spa, color: Colors.green),
                            clearOption: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required!";
                              }
                              return null;
                            },
                            controller: _statusController,
                            textFieldDecoration: const InputDecoration(
                                hintText: "Select Current Stage"),
                            dropDownList: const [
                              DropDownValueModel(
                                  name: "Sprouted", value: "sprouted"),
                              DropDownValueModel(
                                  name: "Small Plant", value: "small plant"),
                              DropDownValueModel(
                                  name: "Adult Plant", value: "adult plant"),
                            ]),
                      ],
                    ),
                  )),
              Center(
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      submit();
                    },
                    child: const Text("Update Status")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration textFeildDecoration(String hintText, IconData? icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(bottom: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.green),
      ),
      hintText: hintText,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: Colors.green),
      ),
    );
  }
}
