import 'package:app_ta/views/home/components/charts/chartOrderanPerbulan.dart';
import 'package:app_ta/views/home/components/charts/orderThisMonth.dart';
import 'package:app_ta/views/home/components/charts/tripBulanIni.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Text('Chart Order Perbulan', style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              ChartOrderanPerbulan(),
              DataOrderPerbulan(),
              TripBulanIni(),
            ],
          ),
        ],
      ),
    );
  }
}