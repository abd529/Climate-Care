// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'package:climate_care/Utility/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../Utility/back_button.dart';
import '../../../common/headers.dart';
import '../controllers/chat_text_controller.dart';

class ChatTextView extends StatefulWidget {
  const ChatTextView({Key? key}) : super(key: key);

  @override
  State<ChatTextView> createState() => _ChatTextViewState();
}

class _ChatTextViewState extends State<ChatTextView> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  double reduced = 0.0;
  double totalRe = 0.0;
  int coins = 0;
  void submit() async {
    if (_formKey.currentState!.validate()) {
      controller.messages = [];
      controller.getTextCompletion(controller_1.text, controller_2.text,
          controller_3.text, controller_4.text, controller_5.text, 0);
      controller.searchTextController.clear();
      if (controller_1.text.isNotEmpty) {
        print(controller_1.text);
        controller_1.clear();
      }
      if (controller_2.text.isNotEmpty) {
        print(controller_2.text);
        controller_2.clear();
      }
      if (controller_3.text.isNotEmpty) {
        print(controller_3.text);
        controller_3.clear();
      }
      if (controller_4.text.isNotEmpty) {
        print(controller_4.text);
        controller_4.clear();
      }
      if (controller_5.text.isNotEmpty) {
        print(controller_5.text);
        controller_5.clear();
      }

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
      if (value == 0) {
        print("value 1 ${dropController1.dropDownValue!.value.toString()}");
        totalRe = dropController1.dropDownValue!.value;
      }

      if (value == 1) {
        print("value 2 ${dropController2.dropDownValue!.value.toString()}");
        totalRe = dropController1.dropDownValue!.value +
            dropController2.dropDownValue!.value;
      }

      if (value == 2) {
        print("value 3 ${dropController3.dropDownValue!.value.toString()}");
        totalRe = dropController1.dropDownValue!.value +
            dropController2.dropDownValue!.value +
            dropController3.dropDownValue!.value;
      }

      if (value == 3) {
        print("value 4 ${dropController4.dropDownValue!.value.toString()}");
        totalRe = dropController1.dropDownValue!.value +
            dropController2.dropDownValue!.value +
            dropController3.dropDownValue!.value +
            dropController4.dropDownValue!.value;
      }

      if (value == 4) {
        print("value 5 ${dropController5.dropDownValue!.value.toString()}");
        totalRe = dropController1.dropDownValue!.value +
            dropController2.dropDownValue!.value +
            dropController3.dropDownValue!.value +
            dropController4.dropDownValue!.value +
            dropController5.dropDownValue!.value;
      }

      FirebaseFirestore.instance
          .collection("Reduced Emission")
          .doc("$userId Reduced")
          .update({"reduced": reduced + totalRe});
      FirebaseFirestore.instance
          .collection("Green Coins")
          .doc("$userId Coins")
          .update({"coins": coins + 20});
      FirebaseFirestore.instance
          .collection("EmissionLevel")
          .doc(userId)
          .update({"recycled": true});

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
                content: Text(
                  "You just reduced approximately \n$totalRe kg CO2 Emissions. \nAnd you earned 20 Green Coins",
                  softWrap: true,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Read the Response"))
                ],
              ));
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController controller_1 = TextEditingController();

  TextEditingController controller_2 = TextEditingController();

  TextEditingController controller_3 = TextEditingController();

  TextEditingController controller_4 = TextEditingController();

  TextEditingController controller_5 = TextEditingController();

  SingleValueDropDownController dropController1 =
      SingleValueDropDownController();

  SingleValueDropDownController dropController2 =
      SingleValueDropDownController();

  SingleValueDropDownController dropController3 =
      SingleValueDropDownController();

  SingleValueDropDownController dropController4 =
      SingleValueDropDownController();

  SingleValueDropDownController dropController5 =
      SingleValueDropDownController();

  int value = 0;

  ChatTextController controller = ChatTextController();

  @override
  Widget build(BuildContext context) {
    //print(dropController1.dropDownValue!.value);
    return Scaffold(
      body: Obx(() => SingleChildScrollView(
            child: SafeArea(
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyBackButton()),
                    const Text(
                      "Waste Reduction Tool",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Header(
                  "Add one or more items that you own and want to recycle!",
                  fontSize: 18,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (value == 0) ...[
                          TextFeildCon(controller_1, dropController1)
                        ] else if (value == 1) ...[
                          TextFeildCon(controller_1, dropController1),
                          TextFeildCon(controller_2, dropController2),
                        ] else if (value == 2) ...[
                          TextFeildCon(controller_1, dropController1),
                          TextFeildCon(controller_2, dropController2),
                          TextFeildCon(controller_3, dropController3),
                        ] else if (value == 3) ...[
                          TextFeildCon(controller_1, dropController1),
                          TextFeildCon(controller_2, dropController2),
                          TextFeildCon(controller_3, dropController3),
                          TextFeildCon(controller_4, dropController4),
                        ] else if (value == 4) ...[
                          TextFeildCon(controller_1, dropController1),
                          TextFeildCon(controller_2, dropController2),
                          TextFeildCon(controller_3, dropController3),
                          TextFeildCon(controller_4, dropController4),
                          TextFeildCon(controller_5, dropController5),
                        ],
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                        onPressed: () {
                          if (value < 4) {
                            setState(() {
                              value++;
                            });
                          }
                          print(value);
                        },
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
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                        onPressed: () {
                          if (value > 0) {
                            setState(() {
                              value--;
                            });
                          }
                          print(value);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.red, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 130,
                  height: 45,
                  margin: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                    ),
                    child: const Text('Sumbit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 7, right: 7, bottom: 5),
                  child: Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green.shade100,
                      ),
                      child: controller.state.value == ApiState.loading
                          ? const Center(child: CircularProgressIndicator())
                          : controller.messages.isEmpty
                              ? const Center(
                                  child: Text(
                                  "Submit items",
                                  style: TextStyle(color: Colors.grey),
                                ))
                              : ListView.builder(
                                  itemCount: controller.messages.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.messages[0].text.trim(),
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: controller
                                                              .messages[0]
                                                              .text));
                                                },
                                                child: const Icon(Icons.copy,
                                                    size: 28)),
                                            InkWell(
                                                onTap: () {
                                                  Share.share(controller
                                                      .messages[0].text);
                                                },
                                                child: const Icon(Icons.share,
                                                    size: 28)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                ),
                const SizedBox(height: 12),
              ]),
            ),
          )),
    );
  }

  Widget TextFeildCon(TextEditingController controller,
      SingleValueDropDownController controller2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required Feild";
                }
                return null;
              },
              decoration: InputDecoration(
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
                  hintText: 'Item Name',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                  )),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: DropDownTextField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Required Feild";
                }
                return null;
              },
              controller: controller2,
              textFieldDecoration: const InputDecoration(
                hintText: "Select Material",
              ),
              dropDownList: const [
                DropDownValueModel(name: "Alumunium", value: 0.15),
                DropDownValueModel(name: "Glass", value: 0.32),
                DropDownValueModel(name: "Plastic", value: 0.11),
                DropDownValueModel(name: "Paper", value: 0.41),
                DropDownValueModel(name: "Cardboard", value: 0.15 / 1000),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
