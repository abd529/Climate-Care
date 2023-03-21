import 'package:flutter/material.dart';

import '../Models/partners.dart';

class PointRedeem extends StatelessWidget {
  const PointRedeem({super.key});

  Widget _redeenCards(Color logocolor, String logoaddress, String cardtext) {
    return SizedBox(
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
                softWrap: true,
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
                'Your Green Coins',
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
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: const Icon(
                        Icons.emoji_nature,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const Text('0'),
                  ],
                ),
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
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: partners.length,
                    itemBuilder: (context, index) => _redeenCards(Colors.yellow,
                        partners[index].logo, "Get 50% discount on all items")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
