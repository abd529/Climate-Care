// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../Utility/back_button.dart';
import '../../../../Utility/header.dart';
import '../../../common/headers.dart';
import '../controllers/chat_text_controller.dart';

class ShopAssistant extends StatefulWidget {
  static const routeName = "shopping-assistant";
  const ShopAssistant({Key? key}) : super(key: key);

  @override
  State<ShopAssistant> createState() => _ShopAssistantState();
}

class _ShopAssistantState extends State<ShopAssistant> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  double reduced = 0.0;
  double totalRe = 0.0;
  int coins = 0;
  void submit() async {
    if (_formKey.currentState!.validate()) {
      if (controller_1.text.isNotEmpty) {
        print(controller_1.text);
        controller_1.clear();
      }
      controller.messages = [];
      controller.getTextCompletion(controller_1.text, "", "", "", "", 1);
      controller.searchTextController.clear();
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
    FirebaseFirestore.instance
        .collection("Reduced Emission")
        .doc("$userId Reduced")
        .update({"reduced": reduced + 1.25});
    FirebaseFirestore.instance
        .collection("Green Coins")
        .doc("$userId Coins")
        .update({"coins": coins + 20});
    FirebaseFirestore.instance
        .collection("EmissionLevel")
        .doc(userId)
        .update({"shopped": true});

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
                "You just reduced approximately \n1.25 kg CO2 Emissions. \nAnd you earned 20 Green Coins",
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Read the Response"))
              ],
            ));
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController controller_1 = TextEditingController();

  int value = 0;

  ChatTextController controller = ChatTextController();

  @override
  Widget build(BuildContext context) {
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
                      "Shopping Assistant",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Header(
                  "Enter a product link that you want to buy for an eco friendly alternative",
                  fontSize: 18,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFeildCon(controller_1),
                      ],
                    )),
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

  Widget TextFeildCon(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            hintText: 'eg: https//:store.com/product',
            hintStyle: const TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}
