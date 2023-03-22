import 'dart:io';

import 'package:climate_care/Models/partners.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

import '../Utility/header.dart';

class PartnerDetails extends StatefulWidget {
  static const routeName = "partner-details";
  final Partners partner;
  const PartnerDetails(this.partner, {super.key});

  @override
  State<PartnerDetails> createState() => _PartnerDetailsState();
}

class _PartnerDetailsState extends State<PartnerDetails> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  int coins = 0;
  int num = 0;
  void getInfo() async {
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
  }

  @override
  Widget build(BuildContext context) {
    Future<File?> downloadFile(String url, String name) async {
      try {
        final appStorage = await getApplicationDocumentsDirectory();
        final file = File("${appStorage.path}/$name");
        final response = await Dio().get(url,
            options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0,
            ));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();

        return file;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    Future openFile({required String url, required String fileName}) async {
      final file = await downloadFile(url, fileName);
      if (file == null) return;
      print("Path: ${file.path}");
      OpenFilex.open(file.path);
    }

    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      num++;
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Header("Meet our partner"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.partner.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(widget.partner.logo)),
                ],
              ),

              heading("Description"),
              Text(
                widget.partner.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              heading("Location"),
              Text(
                widget.partner.location,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              heading("Offer"),
              Text(
                widget.partner.offer,
                style: const TextStyle(fontSize: 16),
              ),
              Center(
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      if (coins < 1000) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  backgroundColor: Colors.lightGreen[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Text("So sorry!"),
                                  content: const Text(
                                      "You do not have enough \nGreen Coins"),
                                ));
                      } else {
                        openFile(
                            url: widget.partner.coupon,
                            fileName: "${widget.partner.name}.pdf");
                      }
                    },
                    child: const Text("Get Coupon")),
              )
            ],
          ),
        ),
      )),
    );
  }

  Text heading(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
    );
  }
}
