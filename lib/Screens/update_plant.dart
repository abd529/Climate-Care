// ignore_for_file: depend_on_referenced_packages

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
  UpdatePlant(this.plant);

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

  void submit() {
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
      Navigator.of(context).pushNamed(GardenScreen.routeName);
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
                    child: const Text("Update data")),
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
