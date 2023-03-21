// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:climate_care/Models/post.dart';
import 'package:climate_care/Utility/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../home.dart';

class AddPost extends StatefulWidget {
  static const routeName = "add-post";
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String profilePicLink = "";
  var _image;
  final _picker = ImagePicker();
  var userid = FirebaseAuth.instance.currentUser!.uid;
  var name = FirebaseAuth.instance.currentUser!.displayName;
  DateTime date = DateTime.now();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    Reference ref =
        FirebaseStorage.instance.ref().child("Profile Pic/${DateTime.now()}");
    _image = File(pickedImage!.path);
    await ref.putFile(_image);
    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
        print("this is photo link $value");
      });
    });
    setState(() {
      _image = File(pickedImage.path);
    });
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePicLink);
  }

  void Submit() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection("Social Posts").add({
        "name": name,
        "date": date,
        "likes": 0,
        "postText": _textController.text,
        "photoLink": profilePicLink
      });
      Navigator.of(context).pushNamed(Home.routeName);
    }
  }

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SocialPost post = SocialPost(
      userName: "Abd",
      date: Timestamp.fromDate(DateTime.now()),
      like: 40,
      postText: "hey this is my plant, stasy",
      postId: DateTime.now().toString(),
      photo:
          "https://i.pinimg.com/originals/2b/2f/3b/2b2f3ba27ceb7cf7736e0071aaf8aefd.jpg");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            const Header(
                "Add a post to share your green activities with your community"),
            Form(
                key: _formKey,
                child: Column(children: [
                  heading("Write Something!"),
                  TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: textFeildDecoration(
                        "eg: Yayyy!I sowed a seed today",
                        Icons.emoji_emotions_outlined),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 228, 228, 228),
                    child: Center(
                      child: _image != null
                          ? Image.file(_image, fit: BoxFit.cover)
                          : TextButton(
                              onPressed: () {
                                _openImagePicker();
                              },
                              child: const Text(
                                "Select a photo",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                    ),
                  )
                ])),
            ElevatedButton(
              onPressed: () {
                Submit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Post"),
            )
          ]),
        ),
      )),
    );
  }

  Widget heading(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
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
