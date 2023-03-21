// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String name;
  final String type;
  final String status;
  final double lat;
  final double lng;
  final String nickName;
  final String location;
  final String plantId;
  final Timestamp date;
  Plant({
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
    required this.status,
    required this.nickName,
    required this.location,
    required this.plantId,
    required this.date,
  });
  factory Plant.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    final plantId = snapshot.id;
    return Plant(
        name: map["name"] as String,
        plantId: plantId,
        lat: map["lat"],
        lng: map["lng"],
        location: map["location"],
        nickName: map["nickName"],
        status: map["plantStatus"],
        type: map["plantType"],
        date: map["date"]);
  }
}

enum PlantType { flowering, non_Flowering }

enum PlantStatus { seed, sprouted, small_Plant, adult_plant }
