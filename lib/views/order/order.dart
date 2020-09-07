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

    String status1 = "Order Sedang di Konfirmasi";
    String status2 = "Order Akan di Belikan";
    String status3 = "Order Dapat di Ambil";

    return MultiProvider(
      providers: [
        StreamProvider<List<OrderModel>>.value(value: OrderController().getAllOrder),
        StreamProvider<List<KotaModel>>.value(value: KotaController().getAllKota),
        StreamProvider<List<TokoModel>>.value(value: TokoController().getAllToko),
        StreamProvider<List<KueModel>>.value(value: KueController().getAllKue),
      ],
      child: DefaultTabController(
        length: 3,
        child: new Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: new AppBar(
            elevation: 0,
            title: Text('Aplikasi Jasa Titip'),
            centerTitle: true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Konfirmasi',),
                Tab(text: 'Dibelikan',),
                Tab(text: 'Diambil',)
              ],
            ),
          ),
          body: TabBarView(
            children:[
              SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        OrderList(status: status1,),
                      ],
                    ),
                  )
              ),
              SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        OrderList(status: status2,),
                      ],
                    ),
                  )
              ),
              SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        OrderList(status: status3,),
                      ],
                    ),
                  )
              ),
            ]
          ),
        ),
      )
    );
  }
}
