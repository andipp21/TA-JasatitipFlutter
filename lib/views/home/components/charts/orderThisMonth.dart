import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/home/components/charts/chartOrderanBulanIni.dart';
import 'package:app_ta/views/home/components/charts/dataTableStatusOrder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataOrderPerbulan extends StatefulWidget {
  @override
  _DataOrderPerbulanState createState() => _DataOrderPerbulanState();
}

class _DataOrderPerbulanState extends State<DataOrderPerbulan> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<OrderModel>>(context);
    int orderBulanIni = 0;

    var bulanIni = DateTime.now().month;

    order.forEach((order) {
      var bulanPesan = order.tanggalPesan.toDate().month;
      if(bulanIni == bulanPesan){
        orderBulanIni++;
      }
    });

    return Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                    'Total orderan bulan ini',
                  style: TextStyle(color: kPrimaryColor),
                ),
                Text(
                  orderBulanIni.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor
                  ),
                ),
                StatusOrderBulanIni(),
                ChartOrderBulanIni()
              ],
            ),
          ),
        ),
    );
  }
}
