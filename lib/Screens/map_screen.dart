// ignore_for_file: avoid_print

import 'dart:ui' as ui;
import 'package:climate_care/Models/plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const routeName = "map";
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _controller;
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
      print(data);
      plantsD.add(Marker(
          markerId: MarkerId(ai.name),
          position: LatLng(ai.lng, ai.lat),
          consumeTapEvents: true,
          infoWindow: InfoWindow(
            onTap: () => Column(children: const [Text("hehe")]),
          )));
    }
    //plantsOb.forEach(() =>
    //map[customer.name] = {'email': data[], 'age': customer.age});
    print(plantsD);
  }

  Future onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller.setMapStyle(value);
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/loca.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_1"),
        position: const LatLng(31.4697, 74.2824),
        infoWindow:
            const InfoWindow(title: 'Dinner at 9pm', snippet: "Johar Town"),
        rotation: 0,
      ),
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_2"),
        position: const LatLng(31.6211, 74.2728),
        infoWindow: const InfoWindow(title: 'Dinner at 9pm', snippet: "Shadra"),
        rotation: 0,
      ),
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_3"),
        position: const LatLng(31.4914, 74.2385),
        infoWindow: const InfoWindow(
            title: 'Dinner at 9pm', snippet: "Thokar Niaz Baig"),
        rotation: 0,
      ),
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_4"),
        position: const LatLng(31.4164, 74.1842),
        infoWindow:
            const InfoWindow(title: 'Dinner at 9pm', snippet: "Izmir Town"),
        rotation: 0,
      ),
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_5"),
        position: const LatLng(31.4032, 74.2560),
        infoWindow:
            const InfoWindow(title: 'Dinner at 9pm', snippet: "Valencia"),
        rotation: 0,
      ),
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_6"),
        position: const LatLng(31.4625, 74.4086),
        infoWindow:
            const InfoWindow(title: 'Dinner at 9pm', snippet: "DHA Phae 5"),
        rotation: 0,
      ),
      Marker(
        icon: markerIcon,
        markerId: const MarkerId("marker_7"),
        position: const LatLng(31.5617, 74.3369),
        infoWindow:
            const InfoWindow(title: 'Dinner at 9pm', snippet: "Garhi Shahu"),
        rotation: 0,
      )
    };
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static const LatLng _kMapCenter = LatLng(31.5204, 74.3587);

  static const CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  void initState() {
    super.initState();
    getBytesFromAsset('assets/loca.png', 150).then((onValue) {
      setState(() {
        markerIcon = BitmapDescriptor.fromBytes(onValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getMarkers());
      num++;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('View All Plants on Map'),
      ),
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: _kInitialPosition,
          markers: _createMarker(),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: onMapCreated,
          trafficEnabled: false,
          zoomControlsEnabled: true,
        ),
      ]),
    );
  }
}
