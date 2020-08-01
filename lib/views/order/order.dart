import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/controllers/kueController.dart';
import 'package:app_ta/controllers/orderController.dart';
import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/order/components/orderList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<OrderModel>>.value(value: OrderController().getAllOrder),
        StreamProvider<List<KotaModel>>.value(value: KotaController().getAllKota),
        StreamProvider<List<TokoModel>>.value(value: TokoController().getAllToko),
        StreamProvider<List<KueModel>>.value(value: KueController().getAllKue),
      ],
      child: new Scaffold(
        backgroundColor: kPrimaryColor,
        body: new SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  OrderList(),
                ],
              ),
            )
        ),
      )
    );
  }
}
