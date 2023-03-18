// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';
import 'package:climate_care/Authentication/lsoption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Waste Reduction/modules/chat_text/controllers/chat_text_controller.dart';
import '../Waste Reduction/modules/chat_text/views/chat_text_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profilePicLink = "";
  var _image;
  final _picker = ImagePicker();
  int num = 0;
  var userid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    Reference ref = FirebaseStorage.instance.ref().child("Profile Pic/$userid");
    num++;
    _image = File(pickedImage!.path);
    await ref.putFile(_image);
    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
        print(value);
      });
    });
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePicLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: _openImagePicker, child: const Text("Pick Image")),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 300,
          color: Colors.grey[300],
          child: _image != null
              ? Image.file(_image, fit: BoxFit.cover)
              : const Text('Please select an image'),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Done")),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed(Option.routeName);
            },
            child: const Text("Log out")),
        ElevatedButton(
            onPressed: () {
              Get.put(ChatTextController());
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const ChatTextView()));
            },
            child: const Text("Waste Reduction Tool"))
      ],
    );
  }
}
