// ignore_for_file: avoid_print

import 'package:climate_care/Screens/add_plant_screen.dart';
import 'package:climate_care/Screens/plant_detail_screen.dart';
import 'package:climate_care/Screens/map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/plant.dart';
import '../Utility/back_button.dart';

class GardenScreen extends StatefulWidget {
  static const routeName = "garden-screen";
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Widget _buildList(QuerySnapshot<Object?>? snapshot) {
    if (snapshot!.docs.isEmpty) {
      return const Center(child: Text("No Plants in the garden Yet!"));
    } else {
      return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final task = Plant.fromSnapshot(doc);
          return _buildListItem(task);
        },
      );
    }
  }

  Widget _buildListItem(Plant plant) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
          width: MediaQuery.of(context).size.width - 30,
          height: MediaQuery.of(context).size.height / 3,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(140, 221, 161, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                bottomLeft: Radius.circular(70),
              )),
          child: Row(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(plant.status == "seed"
                    ? "assets/seed.png"
                    : plant.status == "sprouted"
                        ? "assets/sprouted.png"
                        : plant.status == "small plant"
                            ? "assets/small_plant2.png"
                            : "assets/tree.png"),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plant.nickName,
                      textAlign: TextAlign.right,
                      softWrap: true,
                      style: TextStyle(
                          fontFamily: GoogleFonts.shadowsIntoLight().fontFamily,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        rowMethod("Plant Name:", plant.name),
                        rowMethod("Plant Type:", plant.type),
                        rowMethod("Status:", plant.status),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PlantDetailScreen(plantId: plant.plantId),
                              ));
                            },
                            child: const Text("View Details"))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ]),
    );
  }

  Row rowMethod(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          key,
          textAlign: TextAlign.center,
          softWrap: true,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text.rich(
          TextSpan(
            text: value,
          ),
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Padding(padding: EdgeInsets.all(8.0), child: MyBackButton()),
              Text(
                "My Garden",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlantScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text(
                "Add a Plant",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MapScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Icon(Icons.map_outlined)),
          ),
        ],
      ),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User Plants")
              .doc("$userId Plants")
              .collection("Plants")
              .snapshots(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            print(snapshot.data);
            return SizedBox(
                height: MediaQuery.of(context).size.height / 1.15,
                child: _buildList(snapshot.data));
          }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody(context)));
  }
}
