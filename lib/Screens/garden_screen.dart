import 'package:climate_care/Screens/add_plant_screen.dart';
import 'package:climate_care/Screens/plant_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Models/plant.dart';

class GardenScreen extends StatefulWidget {
  static const routeName = "garden-screen";
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _controller = TextEditingController();

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
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height / 3.5,
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
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
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
                  Container(
                      child: Column(
                    children: [
                      rowMethod("Plant Name:", plant.name),
                      rowMethod("Plant Type:", plant.type),
                      rowMethod("Status:", plant.status),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PlantDetailScreen(plantId: plant.plantId),
                            ));
                          },
                          child: const Text("View Details"))
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      )
    ]);
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromRGBO(140, 221, 161, 1),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    )),
              ),
              const Text(
                " My Garden",
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
                backgroundColor: const Color.fromRGBO(140, 221, 161, 1),
              ),
              child: const Text(
                "Add a Plant",
                style: TextStyle(color: Colors.black),
              ),
            ),
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
            return Container(
                height: MediaQuery.of(context).size.height / 1.211212121212121,
                child: _buildList(snapshot.data));
          }))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _buildBody(context));
  }
}
