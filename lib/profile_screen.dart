import 'dart:io';
import 'package:climate_care/home.dart';
import 'package:climate_care/login_screens/lsoption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profilePicLink = "";
  var _image = null;
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
    return SafeArea(
        child: Column(
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
        ElevatedButton(onPressed: () {}, child: Text("Done")),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed(Option.routeName);
            },
            child: Text("Log out"))
      ],
    ));
  }
}
