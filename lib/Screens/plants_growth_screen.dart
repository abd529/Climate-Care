import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/plant.dart';

class PlantGrowthScreen extends StatefulWidget {
  const PlantGrowthScreen({super.key});

  @override
  State<PlantGrowthScreen> createState() => _PlantGrowthScreenState();
}

class _PlantGrowthScreenState extends State<PlantGrowthScreen> {
  List<Plant> plants = [
    Plant(
        name: "Sydney",
        duration: 32,
        type: PlantType.flowering,
        place: const LatLng(20.2, 52.5)),
    Plant(
        name: "Aloveri",
        duration: 32,
        type: PlantType.flowering,
        place: const LatLng(20.2, 52.5)),
    Plant(
        name: "Mark",
        duration: 32,
        type: PlantType.flowering,
        place: const LatLng(20.2, 52.5))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plants"),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(plants[index].name),
            ),
          ),
        ),
      ),
    );
  }
}
