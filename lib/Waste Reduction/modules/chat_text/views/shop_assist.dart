// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../Utility/header.dart';
import '../../../common/headers.dart';
import '../controllers/chat_text_controller.dart';

class ShopAssistant extends StatefulWidget {
  const ShopAssistant({Key? key}) : super(key: key);

  @override
  State<ShopAssistant> createState() => _ShopAssistantState();
}

class _ShopAssistantState extends State<ShopAssistant> {
  void submit() {
    if (_formKey.currentState!.validate()) {
      if (controller_1.text.isNotEmpty) {
        print(controller_1.text);
        controller_1.clear();
      }
      controller.messages = [];
      controller.getTextCompletion(controller_1.text, "", "", "", "", 1);
      controller.searchTextController.clear();
    }
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController controller_1 = TextEditingController();

  int value = 0;

  ChatTextController controller = ChatTextController();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => value = controller.creator);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Green Shopping Assistant",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(children: [
              const Header(
                  "Enter a product link that you want to buy for an eci friendly alternative"),
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
                padding:
                    const EdgeInsets.only(top: 5, left: 7, right: 7, bottom: 5),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                Clipboard.setData(ClipboardData(
                                                    text: controller
                                                        .messages[0].text));
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
