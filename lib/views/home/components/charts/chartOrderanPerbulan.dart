import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartOrderanPerbulan extends StatefulWidget {
  @override
  _ChartOrderanPerbulanState createState() => _ChartOrderanPerbulanState();
}

class _ChartOrderanPerbulanState extends State<ChartOrderanPerbulan> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<OrderModel>>(context);
    int jan = 0,feb = 0,mar = 0,apr = 0,mei = 0,
        jun = 0,jul = 0,agu = 0,sep = 0,okt = 0,
        nov = 0,des = 0;

    // ignore: missing_return
    order.forEach((order) {
      var tPesan = order.tanggalPesan.toDate();
      var bulanPesan = tPesan.month;
      switch (bulanPesan) {
        case 1 :
          jan++;
          return jan;
        case 2 :
          feb++;
          return feb;
        case 3 :
          mar++;
          return mar;
        case 4 :
          apr++;
          return apr;
        case 5 :
          mei++;
          return mei;
        case 6 :
          jun++;
          return jun;
        case 7 :
          jul++;
          return jul;
        case 8 :
          agu++;
          return agu;
        case 9 :
          sep++;
          return sep;
        case 10 :
          okt++;
          return okt;
        case 11 :
          nov++;
          return nov;
        case 12 :
          des++;
          return des;
      }
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipBottomMargin: 8,
                getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                    ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: SideTitles(
                showTitles: false,
                textStyle: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                ),
                margin: 16,
                reservedSize: 14,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 5: return '5';
                    case 10: return '10';
                    case 15: return '15';
                    default: return '';
                  }
                }
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                textStyle: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                margin: 12,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'Mei';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    case 7:
                      return 'Agu';
                    case 8:
                      return 'Sep';
                    case 9:
                      return 'Okt';
                    case 10:
                      return 'Nov';
                    case 11:
                      return 'Des';
                    default:
                      return '';
                  }
                },
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              BarChartGroupData(
                  x: 0,
                  barRods: [BarChartRodData(y: jan.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 1,
                  barRods: [BarChartRodData(y: feb.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 2,
                  barRods: [BarChartRodData(y: mar.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 3,
                  barRods: [BarChartRodData(y: apr.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 4,
                  barRods: [BarChartRodData(y: mei.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 5,
                  barRods: [BarChartRodData(y: jun.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 6,
                  barRods: [BarChartRodData(y: jul.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 7,
                  barRods: [BarChartRodData(y: agu.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 8,
                  barRods: [BarChartRodData(y: sep.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 9,
                  barRods: [BarChartRodData(y: okt.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 10,
                  barRods: [BarChartRodData(y: nov.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
              BarChartGroupData(
                  x: 11,
                  barRods: [BarChartRodData(y: des.toDouble(), color: Colors.lightBlueAccent)],
                  showingTooltipIndicators: [0]),
            ],
          ),
        ),
      ),
    );

  }
}

