import 'package:climate_care/Screens/partner_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      num++;
    }
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
                    fontSize: 14,
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
                      style: const TextStyle(fontSize: 18),
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
                    fontSize: 16,
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
            ],
          ),
        ),
      ),
    );
  }
}
