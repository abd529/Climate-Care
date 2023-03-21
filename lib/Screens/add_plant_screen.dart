// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:climate_care/Models/plant.dart';
import 'package:climate_care/Screens/garden_screen.dart';
import 'package:climate_care/Utility/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/autocomplate_prediction.dart';
import '../Models/place_auto_complate_response.dart';
import '../Utility/constants.dart';
import '../Utility/location_list_tile.dart';
import '../Utility/network_utility.dart';

class AddPlantScreen extends StatefulWidget {
  static const routeName = "add-plant";
  const AddPlantScreen({Key? key}) : super(key: key);

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  List<AutocompletePrediction> placePredictions = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchPlaceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _sproutDaysController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final SingleValueDropDownController _typeController =
      SingleValueDropDownController();
  String type = PlantType.flowering.name;
  int sproutingDays = 0;
  double lat = 0.0;
  double lng = 0.0;
  String plantStatus = PlantStatus.seed.name;
  String plantLocaion = "";
  String plant_id = DateTime.now().toString();
  DateTime date = DateTime.now();

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com",
        "maps/api/place/autocomplete/json", {"input": query, "key": apiKey});
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  Future<Map<String, dynamic>> fetchPlaceDetails(String placeId) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey'));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final result = decoded['result'];
      print(result["geometry"]["location"]["lat"]);
      print(result["geometry"]["location"]["lng"]);
      setState(() {
        lat = result["geometry"]["location"]["lat"];
        lng = result["geometry"]["location"]["lng"];
      });
      return result;
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<DateTime?> datePick(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      date = pickedDate;
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      setState(() {
        controller.text = formattedDate;
      });
      return DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    } else {
      print("Date is not selected");
      return null;
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      //sproutingDays = int.parse(_sproutDaysController.text.toString());
      final userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance.collection("All Plants").add({
        "name": _nameController.text.trim(),
        "nickName": _nickNameController.text.trim(),
        "lat": lat,
        "lng": lng,
        "plantType": _typeController.dropDownValue!.value,
        "plantStatus": plantStatus,
        "location": plantLocaion,
        "date": date,
        "plantId": plant_id
      });

      FirebaseFirestore.instance
          .collection("User Plants") //folder
          .doc("$userId Plants") //unique id for each user
          .collection("Plants") //folder
          .doc(plant_id)
          .set({
        "name": _nameController.text.trim(),
        "nickName": _nickNameController.text.trim(),
        "lat": lat,
        "lng": lng,
        "plantType": type,
        "plantStatus": plantStatus,
        "location": plantLocaion,
        "date": date
      });
      _nameController.clear();
      _nickNameController.clear();
      _searchPlaceController.clear();
      _sproutDaysController.clear();
      _typeController.clearDropDown();

      Navigator.of(context).pushNamed(GardenScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header("Add Your New Plant Buddy"),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        heading("Enter your plant name"),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required!";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: textFeildDecoration(
                              "eg: Rose, Cactus", Icons.abc_sharp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        heading("Give your plant a nick name"),
                        TextFormField(
                          controller: _nickNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required!";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: textFeildDecoration(
                              "eg: Rosy, cactoo", Icons.yard_outlined),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        heading("Choose your plant type"),
                        DropDownTextField(
                            clearIconProperty: IconProperty(
                                icon: Icons.spa, color: Colors.green),
                            clearOption: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required!";
                              }
                              return null;
                            },
                            controller: _typeController,
                            dropDownList: const [
                              DropDownValueModel(
                                  name: "Flowering", value: "Flowering"),
                              DropDownValueModel(
                                  name: "Non Flowering",
                                  value: "Non flowering"),
                            ]),
                        const SizedBox(
                          height: 10,
                        ),
                        heading("Sprout Date"),
                        TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required!";
                            }
                            return null;
                          },
                          onTap: () {
                            datePick(context, _dateController);
                          },
                          decoration: textFeildDecoration(
                              "Expected date for plant to sprout",
                              Icons.calendar_month_outlined),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        heading("Enter your plant's location"),
                        TextFormField(
                          controller: _searchPlaceController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required!";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            placeAutoComplete(value);
                            print(placePredictions);
                          },
                          textInputAction: TextInputAction.done,
                          decoration: textFeildDecoration(
                              "Search location", Icons.location_on),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        submit();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text("Add Plant to Garden"),
                          Icon(Icons.add_circle_outline),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) => LocationListTile(
                        location: placePredictions[index].description!,
                        press: () {
                          fetchPlaceDetails(
                              placePredictions[index].placeId.toString());
                          _searchPlaceController.text =
                              placePredictions[index].description.toString();
                          setState(() {
                            plantLocaion =
                                placePredictions[index].description.toString();
                            placePredictions = [];
                          });
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text heading(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
    );
  }

  InputDecoration textFeildDecoration(String hintText, IconData? icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(bottom: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.green),
      ),
      hintText: hintText,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: Colors.green),
      ),
    );
  }
}
