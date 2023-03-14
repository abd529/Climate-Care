import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/plant.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(plant.name),
              Text(plant.nickName),
              Text(plant.location),
              Text(plant.status),
              Text(plant.type),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text("hrh"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text("hrh"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text("hrh"),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Text("hrh"),
                ),
              ]),
              CountdownTimer(
                targetDate: tmTodate,
              )
            ],
          ),
        ),
      ),
    );
  }
}
