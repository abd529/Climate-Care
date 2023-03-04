import 'package:google_maps_flutter/google_maps_flutter.dart';

class Plant {
  final String name;
  final Enum type;
  final int duration;
  final LatLng place;
  final String nickName;
  Plant(
      {required this.name,
      required this.type,
      required this.duration,
      required this.place,
      this.nickName = ""});
}

enum PlantType { flowering, non_Flowering }
