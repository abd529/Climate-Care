// ignore_for_file: unnecessary_overrides, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../common/headers.dart';
import '../../../model/text_completion_model.dart';

String text = "";

class ChatTextController extends GetxController {
  // ignore: todo
  //TODO: Implement ChatTextController

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<TextCompletionData> messages = [];
  int creator = 0;
  var state = ApiState.notFound.obs;

  addCreator() {
    if (creator <= 4) {
      creator++;
    }
    update();
    notifyChildrens();
    refresh();
  }

  removeCreator() {
    if (creator > 0) {
      creator--;
    }
    update();
    notifyChildrens();
    refresh();
  }

  getTextCompletion(String query1, String query2, String query3, String query4,
      String query5, int check) async {
    if (check == 0) {
      text =
          "Tell me one thing that I can make by recycling  $query1, $query2, $query3, $query4, $query5 and how can I make it";
      searchTextController.text = text;
      addMyMessage();
    } else {
      text = "Give me link to an eco firendly alternative product for $query1";
      searchTextController.text = text;
      addMyMessage();
    }

    state.value = ApiState.loading;

    try {
      Map<String, dynamic> rowParams = {
        "model": "text-davinci-003",
        "prompt": text,
        "max_tokens": 50,
      };

      final encodedParams = json.encode(rowParams);

      final response = await http.post(
        Uri.parse(endPoint("completions")),
        body: encodedParams,
        headers: headerBearerOption(OPEN_AI_KEY),
      );
      print("Response  body     ${response.body}");
      if (response.statusCode == 200) {
        // messages =
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
        //
        addServerMessage(
            TextCompletionModel.fromJson(json.decode(response.body)).choices);
        state.value = ApiState.success;
      } else {
        // throw ServerException(message: "Image Generation Server Exception");
        state.value = ApiState.error;
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr");
    } finally {
      // searchTextController.clear();
      update();
    }
  }

  addServerMessage(List<TextCompletionData> choices) {
    for (int i = 0; i < choices.length; i++) {
      messages.insert(0, choices[i]);
    }
    print(messages[0].text);
  }

  addMyMessage() {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    TextCompletionData text = TextCompletionData(
      text: searchTextController.text,
      index: 0,
      finish_reason: "lenght",
    );
    //messages.insert(0, text);
  }

  TextEditingController searchTextController = TextEditingController();
}
