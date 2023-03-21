// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:climate_care/Utility/header.dart';
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
  void submit() {
    if (_formKey.currentState!.validate()) {
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
      controller.getTextCompletion(controller_1.text, controller_2.text,
          controller_3.text, controller_4.text, controller_5.text, 0);
      controller.searchTextController.clear();
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController controller_1 = TextEditingController();

  TextEditingController controller_2 = TextEditingController();

  TextEditingController controller_3 = TextEditingController();

  TextEditingController controller_4 = TextEditingController();

  TextEditingController controller_5 = TextEditingController();

  int value = 0;

  ChatTextController controller = ChatTextController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SingleChildScrollView(
            child: SafeArea(
              child: Column(children: [
                Row(
                  children: const [
                    Padding(
                        padding: EdgeInsets.all(8.0), child: MyBackButton()),
                    Text(
                      "Waste Reduction Tool",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Header(
                    "Add one or more items that you own and want to recycle!"),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (value == 0) ...[
                          TextFeildCon(controller_1)
                        ] else if (value == 1) ...[
                          TextFeildCon(controller_1),
                          TextFeildCon(controller_2),
                        ] else if (value == 2) ...[
                          TextFeildCon(controller_1),
                          TextFeildCon(controller_2),
                          TextFeildCon(controller_3),
                        ] else if (value == 3) ...[
                          TextFeildCon(controller_1),
                          TextFeildCon(controller_2),
                          TextFeildCon(controller_3),
                          TextFeildCon(controller_4),
                        ] else if (value == 4) ...[
                          TextFeildCon(controller_1),
                          TextFeildCon(controller_2),
                          TextFeildCon(controller_3),
                          TextFeildCon(controller_4),
                          TextFeildCon(controller_5),
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
            hintText: '#item',
            hintStyle: const TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}
