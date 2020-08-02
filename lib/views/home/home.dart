import 'package:app_ta/controllers/tripController.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/home/components/body.dart';
import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/controllers/kueController.dart';
import 'package:app_ta/controllers/orderController.dart';
import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/views/home/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<OrderModel>>.value(value: OrderController().getAllOrder),
        StreamProvider<List<KotaModel>>.value(value: KotaController().getAllKota),
        StreamProvider<List<TokoModel>>.value(value: TokoController().getAllToko),
        StreamProvider<List<KueModel>>.value(value: KueController().getAllKue),
        StreamProvider<List<TripModel>>.value(value: TripController().getAllTrip)
      ],
      child: Scaffold(
        appBar: appHeader(),
        drawer: new Drawer(
          child: AppDrawer(),
        ),
        backgroundColor: kPrimaryColor,
        body: new SafeArea(
            child: Body()
        ),
      ),
    );
  }

  AppBar appHeader(){
    return AppBar(
      elevation: 0,
      title: Text('Aplikasi Jasa Titip'),
      centerTitle: true,
    );
  }
        
}

