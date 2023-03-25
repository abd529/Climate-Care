// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:climate_care/Authentication/lsoption.dart';

import 'coming_soon.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String profilePicLink = "";
  int num = 0;
  var userid = FirebaseAuth.instance.currentUser!.uid;
  final name = FirebaseAuth.instance.currentUser!.displayName;
  String? photo = "";

  Widget headText(String head) {
    return Text(
      head,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget settingButton(String btext, int check) {
    if (check == 1) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ComingSoon.routeName);
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black26,
              ),
            ),
          ),
          child: Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () {},
                child: Text(btext),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
        ),
      );
    }
    return SizedBox(
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
            onPressed: () {},
            child: Text(btext),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: 200,
                        height: 100,
                        child: CircleAvatar(
                            backgroundImage:
                                const AssetImage('assets/cli-matee.png'),
                            child: TextButton(
                              onPressed: () {},
                              child: Container(
                                width: 200,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )),
                      ),
                      Text(
                        '$name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
              headText('General'),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      settingButton('Edit Profile', 1),
                      settingButton('Change Location', 1),
                      settingButton('Change Language', 0)
                    ],
                  ),
                ),
              ),
              headText('Privacy'),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 20),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      settingButton('Change Password', 1),
                      settingButton('Change Account', 0)
                    ],
                  ),
                ),
              ),
              headText('Terms And Support'),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      settingButton('Terms and Condition', 1),
                      settingButton('Privacy policy', 1),
                      settingButton('Support', 0)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 110,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Option(),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.logout_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Logout",
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            )))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
