import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  void _addTask() {
    Duration sprouting = Duration(days: 90);
    final today = DateTime.now();
    final DateTime sproutDate = today.add(sprouting);
    final todayDate = DateTime(2023, 3, 12);
    print(daysBetween(todayDate, sproutDate));
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

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
    return Container(
        color: Colors.red,
        child: ListTile(
          title: Text(plant.name),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: "Enter task name"),
            )),
            TextButton(
              child:
                  const Text("Add Task", style: TextStyle(color: Colors.green)),
              onPressed: () {
                _addTask();
              },
            )
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
              return Expanded(child: _buildList(snapshot.data));
            }))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Garden")),
      body: _buildBody(context),
    );
  }
}
