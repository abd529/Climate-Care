// ignore_for_file: prefer_const_constructors

import 'package:climate_care/login_quiz/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  final double em;
  const HomeScreen(this.em, {super.key});

  final Color dark = Colors.green;
  final Color normal = Colors.orange;
  final Color light = Colors.red;

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool value = false;
  Widget bottomTitles(double value, TitleMeta meta) {
    TextStyle style =
        GoogleFonts.poppins(fontSize: 9.25, fontWeight: FontWeight.bold);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Your Emissions';
        break;
      case 1:
        text = 'Global Emissions';
        break;
      case 2:
        text = 'PAK Emissions';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "${meta.formattedValue} Ton",
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Hello ",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(fontSize: 18)),
                    Text("Abdullah!",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.green)),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset("assets/cli-matee.png"),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu_rounded,
                      size: 40,
                      color: Colors.green[700],
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            heading("Carbon Emissions Level"),
            AspectRatio(
              aspectRatio: 1.26,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final barsSpace = 62.0 * constraints.maxWidth / 400;
                    final barsWidth = 50.0 * constraints.maxWidth / 400;
                    return BarChart(
                      swapAnimationDuration:
                          Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear,
                      BarChartData(
                          alignment: BarChartAlignment.center,
                          barTouchData: BarTouchData(
                            enabled: true,
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: bottomTitles,
                                reservedSize: 28,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 45,
                                getTitlesWidget: leftTitles,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            checkToShowHorizontalLine: (value) =>
                                value % 10 == 0,
                            getDrawingHorizontalLine: (value) => FlLine(
                              //color: AppColors.borderColor.withOpacity(0.1),
                              strokeWidth: 1,
                            ),
                            drawVerticalLine: false,
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          groupsSpace: barsSpace,
                          barGroups: getData(barsWidth, barsSpace)),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            heading("Weekly Steps to be Eco Friendly"),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Plant a seed"),
                        Checkbox(
                          value: true,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.green.withOpacity(.32);
                            }
                            return Colors.green;
                          }),
                          onChanged: (bool? newValue) {
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Recycle a news paper"),
                        Checkbox(
                          value: value,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.green.withOpacity(.32);
                            }
                            return Colors.green;
                          }),
                          onChanged: (bool? newValue) {
                            setState(() {});
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Use eco friendly product"),
                        Checkbox(
                          value: value,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.green.withOpacity(.32);
                            }
                            return Colors.green;
                          }),
                          onChanged: (bool? newValue) {
                            setState(() {});
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 5, bottom: 5),
                                child: Text(
                                  "This is a very motivational quote for a climate change movement",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Positioned(
                  left: 130,
                  top: 30,
                  bottom: 0,
                  child: SizedBox(
                      height: 300,
                      width: 300,
                      child: SvgPicture.asset("assets/tree_svg.svg")),
                ),
                Positioned(
                    top: 20,
                    left: 05,
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset("assets/quotes.svg"))),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            heading("My Plants"),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 185, 244, 117),
                                    border: Border.all(
                                        width: 5, color: Colors.green),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child:
                                      SvgPicture.asset("assets/plant_icon.svg"),
                                )),
                          ),
                          Text(
                            "Sprouted",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "20%",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: proBar(0.2, false),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // heading("Why we need to care about Climate Change?"),
            CarouselSlider(
              options: CarouselOptions(height: 400.0),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.lightGreen),
                        child: Center(
                          child: Text(
                            'image $i',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ));
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  Text heading(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
            toY: widget.em,
            color: Colors.blue,
            rodStackItems: [
              BarChartRodStackItem(
                0,
                30,
                widget.dark,
              ),
              BarChartRodStackItem(20, 120, widget.dark),
              BarChartRodStackItem(120, widget.em, widget.dark),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(05), topRight: Radius.circular(05)),
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              toY: 7000,
              rodStackItems: [
                BarChartRodStackItem(0, 130, widget.normal),
                BarChartRodStackItem(130, 140, widget.normal),
                BarChartRodStackItem(140, 7000, widget.normal),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(05), topRight: Radius.circular(05)),
              width: barsWidth),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              toY: 5000,
              rodStackItems: [
                BarChartRodStackItem(0, 60.5, widget.light),
                BarChartRodStackItem(60.5, 180, widget.light),
                BarChartRodStackItem(180, 5000, widget.light),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(05), topRight: Radius.circular(05)),
              width: barsWidth),
        ],
      ),
    ];
  }
}
