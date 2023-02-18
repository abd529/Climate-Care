// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final Color dark = Colors.deepPurpleAccent;
  final Color normal = Colors.cyan;
  final Color light = Colors.blue;

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
 Widget bottomTitles(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold);
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
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hello ", textAlign: TextAlign.start, style: GoogleFonts.poppins(fontSize: 18 )),
              Text("Abdullah!",style: GoogleFonts.poppins(fontWeight: FontWeight.bold ,fontSize: 22, color: Colors.green ))
            ],
          ),
          SizedBox(height: 10,),
          Text("Carbon Emissions"),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 5.2, blurStyle: BlurStyle.outer),],
              borderRadius: BorderRadius.circular(15),
              ),
            child: AspectRatio(
              aspectRatio: 1.36,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final barsSpace = 92.0 * constraints.maxWidth / 400;
                    final barsWidth = 4.0 * constraints.maxWidth / 400;
                    return BarChart(
                       swapAnimationDuration: Duration(milliseconds: 150), // Optional
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
                              reservedSize: 40,
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
                          checkToShowHorizontalLine: (value) => value % 10 == 0,
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
                        barGroups: getData(barsWidth, barsSpace)
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 30,
        barRods: [
          BarChartRodData(
            toY: 170,
            color: Colors.blue,
            rodStackItems: [
              BarChartRodStackItem(0, 30, widget.dark,),
              BarChartRodStackItem(20, 120, widget.normal),
              BarChartRodStackItem(120, 170, widget.light),
            ],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(05) , topRight: Radius.circular(05) ),
            width: 30,
          ),
         ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 30,
        barRods: [
          BarChartRodData(
            toY: 240,
            rodStackItems: [
              BarChartRodStackItem(0, 130, widget.dark),
              BarChartRodStackItem(130, 140, widget.normal),
              BarChartRodStackItem(140, 240, widget.light),
            ],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(05) , topRight: Radius.circular(05) ),
            width: 30,
          ),
         ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 30,
        barRods: [
          BarChartRodData(
            toY: 230.5,
            rodStackItems: [
              BarChartRodStackItem(0, 60.5, widget.dark),
              BarChartRodStackItem(60.5, 180, widget.normal),
              BarChartRodStackItem(180, 230.5, widget.light),
            ],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(05) , topRight: Radius.circular(05)),
            width: 30,
          ),
         ],
      ),
    ];
  }
}