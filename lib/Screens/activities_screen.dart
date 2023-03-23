import 'package:climate_care/Screens/garden_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Artificial Inteligence/modules/chat_text/controllers/chat_text_controller.dart';
import '../Artificial Inteligence/modules/chat_text/views/chat_text_view.dart';
import '../Artificial Inteligence/modules/chat_text/views/shop_assist.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Activites",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(GardenScreen.routeName);
              },
              splashColor: Colors.green,
              child: rowMethod(context, "assets/Plant growth.png",
                  "Plant Growth Tracker keep record of your app status and it's conditions. It will help you take care of many palnts at the same time"),
            ),
            InkWell(
              onTap: () {
                Get.put(ChatTextController());
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ChatTextView()));
              },
              splashColor: Colors.green,
              child: rowMethod(context, "assets/Wastage.png",
                  "Waste Reduction Tool helps you recycle those things that are waste for you"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ShopAssistant.routeName);
              },
              splashColor: Colors.green,
              child: rowMethod(context, "assets/shopping.png",
                  "Waste Reduction Tool helps you recycle those things that are waste for you"),
            ),
            InkWell(
              onTap: () {},
              child: rowMethod(context, "assets/ene.png", "energy"),
            )
          ],
        ),
      ),
    );
  }

  SizedBox rowMethod(BuildContext context, String img, String text) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        color: const Color.fromARGB(255, 227, 252, 199),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 150, width: 150, child: Image.asset(img)),
              SizedBox(
                width: 200,
                child: Text(
                  text,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
