// ignore_for_file: avoid_print

import 'dart:io';

import 'package:climate_care/Models/partners.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

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

  Widget offerWidget(String text, Color logoColor, String logoAddress) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width),
      height: MediaQuery.of(context).size.height / 6,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: logoColor),
            ),
            Container(
              width: MediaQuery.of(context).size.height / 9,
              height: MediaQuery.of(context).size.height / 9,
              transform: Matrix4.translationValues(-25, 0, 0),
              child: Image.asset(logoAddress),
            ),
            Container(
              transform: Matrix4.translationValues(-20, 0, 0),
              child: Text(
                text,
                softWrap: true,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset("assets/coin.svg"),
                ),
                const Text(
                  "1000",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
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
      FirebaseFirestore.instance
          .collection("Green Coins")
          .doc("$userId Coins")
          .update({"coins": coins - 1000});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Header("Meet our partner"),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 2) - 100,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      color: widget.partner.logoColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  height: (MediaQuery.of(context).size.height / 2) - 200,
                  width: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 50,
                  right: 50,
                  child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset(widget.partner.logo)),
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.partner.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //heading("Description"),
            Center(
              child: Text(
                widget.partner.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // heading("Location"),
            // Text(
            //   widget.partner.location,
            //   style: const TextStyle(fontSize: 16),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: heading("Offers"),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height / 5) + 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.partner.offer.length,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: offerWidget(widget.partner.offer[index],
                        widget.partner.logoColor, widget.partner.logo)),
              ),
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
