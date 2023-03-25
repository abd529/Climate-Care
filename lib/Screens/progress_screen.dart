// ignore_for_file: avoid_print

import 'package:climate_care/Screens/redeem_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../Models/partners.dart';

class PointRedeem extends StatefulWidget {
  const PointRedeem({super.key});

  @override
  State<PointRedeem> createState() => _PointRedeemState();
}

class _PointRedeemState extends State<PointRedeem> {
  int num = 0;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  int coins = 0;
  double reduced = 0;
  double totalEm = 0;
  double reducedEm = 0;
  int plantsNum = 0;

  Widget _redeenCards(
      Partners partner, Color logocolor, String logoaddress, String cardtext) {
    return InkWell(
      splashColor: Colors.green,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => PartnerDetails(partner),
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 6,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Container(
                width: 50,
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    color: logocolor),
              ),
              Container(
                width: MediaQuery.of(context).size.height / 9,
                height: MediaQuery.of(context).size.height / 9,
                transform: Matrix4.translationValues(-25, 0, 0),
                child: Image.asset(logoaddress),
              ),
              Container(
                transform: Matrix4.translationValues(-20, 0, 0),
                child: Text(
                  cardtext,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("All Plants").get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      plantsNum = allData.length;
    });
    final docSnapshotEm = await FirebaseFirestore.instance
        .collection('EmissionLevel')
        .doc(userId)
        .get();
    if (docSnapshotEm.exists) {
      Map<String, dynamic>? data = docSnapshotEm.data();
      var value = data?['Emission'];
      print(value);
      setState(() {
        totalEm = value;
      });
    }
    final docSnapshotReduced = await FirebaseFirestore.instance
        .collection("Reduced Emission")
        .doc("$userId Reduced")
        .get();
    if (docSnapshotReduced.exists) {
      Map<String, dynamic>? data = docSnapshotReduced.data();
      var value = data?['reduced'];
      print(value);
      setState(() {
        reduced = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      num++;
    }
    reducedEm =
        double.parse(((reduced / totalEm) * 100).toStringAsFixed(1)) * 100;
    print("percent: $reducedEm");
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your Green Coins',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        // width: 50,
                        // height: 50,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: SvgPicture.asset("assets/coin.svg")),
                    Text(
                      coins.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Redeem Coins:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    itemCount: partners.length,
                    itemBuilder: (context, index) => _redeenCards(
                        partners[index],
                        partners[index].logoColor,
                        partners[index].logo,
                        "Get 50% discount on all items")),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Number of \nCarbon Emissions \nReduced",
                    softWrap: true,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SimpleCircularProgressBar(
                      valueNotifier: reducedEm >= 0.1
                          ? ValueNotifier(10)
                          : reducedEm >= 0.2
                              ? ValueNotifier(20)
                              : reducedEm >= 0.3
                                  ? ValueNotifier(30)
                                  : reducedEm >= 0.4
                                      ? ValueNotifier(40)
                                      : reducedEm >= 0.5
                                          ? ValueNotifier(50)
                                          : reducedEm >= 0.6
                                              ? ValueNotifier(60)
                                              : reducedEm >= 0.7
                                                  ? ValueNotifier(70)
                                                  : reducedEm >= 0.8
                                                      ? ValueNotifier(80)
                                                      : reducedEm >= 0.9
                                                          ? ValueNotifier(90)
                                                          : reducedEm >= 1
                                                              ? ValueNotifier(
                                                                  100)
                                                              : reducedEm == 0
                                                                  ? ValueNotifier(
                                                                      0)
                                                                  : ValueNotifier(
                                                                      40),
                      mergeMode: true,
                      fullProgressColor: Colors.blue,
                      backColor: Colors.blueGrey,
                      progressColors: const [
                        Colors.green,
                        Colors.amberAccent,
                        Colors.lightGreen,
                      ],
                      onGetText: (double value) {
                        TextStyle centerTextStyle = const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        );

                        return Text(
                          "${reduced.toStringAsFixed(2)} \nkg",
                          textAlign: TextAlign.center,
                          style: centerTextStyle,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Number of \nPlants planted by \nour users",
                    softWrap: true,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SimpleCircularProgressBar(
                      valueNotifier: plantsNum == 0
                          ? ValueNotifier(30)
                          : ValueNotifier(40),
                      mergeMode: true,
                      fullProgressColor: Colors.blue,
                      backColor: Colors.blueGrey,
                      progressColors: const [
                        Colors.green,
                        Colors.amberAccent,
                        Colors.lightGreen,
                      ],
                      onGetText: (double value) {
                        TextStyle centerTextStyle = const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        );

                        return Text(
                          plantsNum.toString(),
                          textAlign: TextAlign.center,
                          style: centerTextStyle,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
