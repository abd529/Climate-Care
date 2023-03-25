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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Activites",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(GardenScreen.routeName);
              },
              splashColor: Colors.green,
              child: rowMethod(context, "assets/Plant growth.png",
                  "The Plant Growth Tracker simplifies plant care and provides timely reminders for optimal growth. Enjoy healthy, thriving plants with ease."),
            ),
            InkWell(
              onTap: () {
                Get.put(ChatTextController());
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ChatTextView()));
              },
              splashColor: Colors.green,
              child: rowMethod(context, "assets/Wastage.png",
                  "Just enter your items and materials, and get suggestions on what to recycle. Reduce waste and help the environment with ease!"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ShopAssistant.routeName);
              },
              splashColor: Colors.green,
              child: rowMethod(context, "assets/shopping.png",
                  "Just enter a product URL and get suggestions for eco-friendly alternatives. Make a positive impact on the planet with ease!"),
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
