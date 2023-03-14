import 'package:climate_care/Models/plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int num = 0;
  late Plant ai = Plant(
      name: "name",
      type: "type",
      lat: 0,
      lng: 0,
      status: "status",
      nickName: "nickName",
      location: "location",
      plantId: "plantId",
      date: Timestamp(0, 0));
  Set<Marker> plantsD = {
    const Marker(
      markerId: MarkerId("marker_1"),
      position: LatLng(31.529217407697804, 74.35144379080705),
      infoWindow:
          InfoWindow(title: 'Dinner at 9pm', snippet: "hhhhhhhhhhhhhhhhhhhh"),
      rotation: 0,
    ),
  };
  Future<void> getMarkers() async {
    final CollectionReference usersRef =
        FirebaseFirestore.instance.collection('All Plants');
    final QuerySnapshot snapshot = await usersRef.get();
    final List<QueryDocumentSnapshot> documents = snapshot.docs;

    for (final doc in documents) {
      Map data = doc.data() as Map;
      if (data != null) {
        Plant i = Plant(
            name: data["name"],
            type: data["plantType"],
            lat: data["lat"],
            lng: data["lng"],
            status: data["plantStatus"],
            nickName: data["nickName"],
            location: data["location"],
            plantId: data["plantId"],
            date: data["date"]);
      }
      print(data);
      plantsD.add(Marker(
          markerId: MarkerId(ai.name),
          position: LatLng(ai.lng, ai.lat),
          consumeTapEvents: true,
          infoWindow: InfoWindow(
            onTap: () => Column(children: [const Text("hehe")]),
          )));
    }
    //plantsOb.forEach(() =>
    //map[customer.name] = {'email': data[], 'age': customer.age});
    print(plantsD);
  }

  Set<Marker> _createMarker() {
    return {
      const Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(31.6211127, 27.2823662),
        infoWindow:
            InfoWindow(title: 'Dinner at 9pm', snippet: "hhhhhhhhhhhhhhhhhhhh"),
        rotation: 0,
      )
    };
  }

  static const LatLng _kMapCenter =
      LatLng(19.018255973653343, 72.84793849278007);

  static final CameraPosition _kInitialPosition = const CameraPosition(
      target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);
  @override
  Widget build(BuildContext context) {
    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getMarkers());
      num++;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Demo'),
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: _kInitialPosition,
          markers: _createMarker(),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
        ),
        ElevatedButton(
            onPressed: () {
              getMarkers();
            },
            child: const Text("heh")),
        Positioned(
          bottom: 0,
          child: ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("data")),
        )
      ]),
    );
  }
}
