// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Plant {
  final String name;
  final String type;
  final String status;
  final int sproutingDuration;
  final double lat;
  final double lng;
  final String nickName;
  final String location;
  final String plantId;
  Plant(
      {required this.name,
      required this.type,
      required this.sproutingDuration,
      required this.lat,
      required this.lng,
      required this.status,
      required this.nickName,
      required this.location,
      required this.plantId});
  factory Plant.fromSnapshot(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    final plant_id = snapshot.id;
    return Plant(
        name: map["name"] as String,
        plantId: plant_id,
        lat: map["lat"],
        lng: map["lng"],
        location: map["location"],
        nickName: map["nickName"],
        sproutingDuration: 7,
        status: map["plantStatus"],
        type: map["plantType"]);
  }
}

enum PlantType { flowering, non_Flowering }

enum PlantStatus { seed, sprouted, small_Plant, adult_plant }
