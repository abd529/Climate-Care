import 'package:flutter/material.dart';

class Partners {
  final String name;
  final String location;
  final String description;
  final List offer;
  final String logo;
  final String coupon;
  final Color logoColor;
  Partners(
      {required this.name,
      required this.location,
      required this.description,
      required this.offer,
      required this.logo,
      required this.coupon,
      required this.logoColor});
}

final List<Partners> partners = [
  Partners(
    name: "Zohra Shopping Mart",
    location: "A block, plot no 61, Izmir Housing Society, Canal Road, Lahore",
    description:
        "Zohra Shopping Mart is a mordern and huge shopping center providing all essential and other goods for the local people at the best prices. We also deal in whole sale. Visit us at our store in Izmir Society to learn more about us",
    offer: ["Get 50% discout on all items"],
    logo: "assets/zohra.png",
    coupon:
        "https://firebasestorage.googleapis.com/v0/b/climate-care-fa06f.appspot.com/o/Coupons%2Fzohra.pdf?alt=media&token=07901161-d3c2-4809-83d5-16b77568ba89",
    logoColor: Colors.purple,
  ),
  Partners(
      name: "Prime Mart",
      location:
          "A block, plot no 152, Izmir Housing Society, Canal Road, Lahore",
      description:
          "Prime Mart is a mordern and huge shopping center providing all essential and other goods for the local people at the best prices. We also deal in whole sale. Visit us at our store in Izmir Society to learn more about us",
      offer: ["Get 50% discout on all items"],
      logo: "assets/prime.png",
      coupon:
          "https://firebasestorage.googleapis.com/v0/b/climate-care-fa06f.appspot.com/o/Coupons%2Fprime.pdf?alt=media&token=ea829c2b-67f2-43e4-92a6-5068801d989c",
      logoColor: Colors.black),
];
