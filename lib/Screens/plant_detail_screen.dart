import 'package:climate_care/Screens/update_plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/plant.dart';
import '../Utility/back_button.dart';
import '../Utility/timer.dart';

class PlantDetailScreen extends StatefulWidget {
  static const routeName = "plant-details";
  final dynamic plantId;
  PlantDetailScreen({required this.plantId});

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  Plant plant = Plant(
    name: "name",
    type: "plantType",
    lat: 0.0,
    lng: 0.0,
    status: "plantStatus",
    nickName: "nickName",
    location: "location",
    plantId: "plantId",
    date: Timestamp(0, 0),
  );
  int num = 0;
  int day = 0;
  int hour = 0;
  int min = 0;
  int sec = 0;
  Timestamp sproutDate = Timestamp(95, 21);
  DateTime tmTodate = DateTime.now();
  bool isExpired = false;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<Plant> getDetails() async {
    var collection = FirebaseFirestore.instance
        .collection('User Plants')
        .doc("$userId Plants")
        .collection("Plants");
    var docSnapshot = await collection.doc(widget.plantId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      if (data != null) {
        Timestamp fetchedDate = data["date"];
        //int days = data["sproutingDuration"];
        //print("days left: $days");
        final today = DateTime.now();
        tmTodate = sproutDate.toDate();
        //today.add(Duration(days: days));
        setState(() {
          tmTodate = fetchedDate.toDate();
          plant = Plant(
            name: data["name"],
            type: data["plantType"],
            lat: data["lat"],
            lng: data["lng"],
            status: data["plantStatus"],
            nickName: data["nickName"],
            location: data["location"],
            plantId: widget.plantId,
            date: fetchedDate,
          );
          final now = DateTime.now();
          final expirationDate = plant.date.toDate();
          isExpired = expirationDate.isBefore(now);
        });
        return plant;
      } else {
        return null as Plant;
      }
    }
    return null as Plant;
  }

  @override
  Widget build(BuildContext context) {
    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getDetails());
      num++;
    }
    DateTime dateU = plant.date.toDate();
    String date = "${dateU.year}-${dateU.month}-${dateU.day}";
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(233, 249, 238, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyBackButton(),
                        Text(
                          plant.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isExpired ? Colors.green : Colors.grey),
                              onPressed: () {
                                if (isExpired) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => UpdatePlant(plant)));
                                } else {}
                              },
                              child: const Text("Update")),
                        )
                      ]),
                ),
                Column(
                  children: [
                    textRow("Nickname:", plant.nickName),
                    textRow("Plant Type:", plant.type),
                    textRow("Plant Growth Status:", plant.status),
                    textRow("Sowed at:", plant.location),
                    textRow("Next Update:", date)
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: MediaQuery.of(context).size.height / 2,
              child: SizedBox(
                  height: 170,
                  width: 170,
                  child: Image.asset(plant.status == "seed"
                      ? "assets/seed.png"
                      : plant.status == "sprouted"
                          ? "assets/sprouted.png"
                          : plant.status == "small plant"
                              ? "assets/small_plant2.png"
                              : "assets/tree.png")),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height / 2.5,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Plant info",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
            Positioned(
                bottom: MediaQuery.of(context).size.height / 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hi, I am ${plant.nickName}, I am a ${plant.name}.\nI live in ${plant.location} \nand I am ${plant.status}. \nIf you take care of me we both can make \nthis world a better place",
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                )),
            const Positioned(
              bottom: 100,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Time for next update",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: CountdownTimer(
                  targetDate: tmTodate,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Padding textRow(String text, String text2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text2,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
