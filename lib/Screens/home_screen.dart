// ignore_for_file: prefer_const_constructors

import 'package:climate_care/login_quiz/progressbar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
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
                          value: value,
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
              child: Stack(
                children: [Text("\"Quotation\"")],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            heading("My Progress"),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            LineIcons.tree,
                            size: 35,
                            fill: 1.0,
                            color: Color.fromARGB(255, 1, 106, 5),
                          ),
                          Text(
                            "20%",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "2/10",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      proBar(0.2, false),
                    ],
                  ),
                ))
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
