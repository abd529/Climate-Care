import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PointRedeem extends StatelessWidget {
  const PointRedeem({super.key});

  Widget _activityCard(String text) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _redeenCards(Color logocolor, String logoaddress, String cardtext) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: logocolor),
            ),
            Container(
              width: 50,
              height: 50,
              transform: Matrix4.translationValues(-25, 0, 0),
              child: Image.asset(logoaddress),
            ),
            Container(
              transform: Matrix4.translationValues(-20, 0, 0),
              child: Text(
                cardtext,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your points',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Icon(
                        Icons.nature_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    Text('1290'),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Completed Activities:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                ),
                items: [
                  _activityCard('1'),
                  _activityCard('2'),
                  _activityCard('3'),
                  _activityCard('4'),
                  _activityCard('5')
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: i,
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Redeem Coins:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _redeenCards(Colors.yellow, 'assets/mcdonalds.png',
                  'Get a McChicken with free\nCoke or sprite'),
              _redeenCards(Colors.black, 'assets/kfc.png',
                  'Added KFC because\nKFC is Love')
            ],
          ),
        ),
      ),
    );
  }
}
