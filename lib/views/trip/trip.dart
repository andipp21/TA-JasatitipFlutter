import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/controllers/tripController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/trip/components/tripList.dart';
import 'package:app_ta/views/trip/crudScreen/tambahTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<List<TripModel>>.value(value: TripController().getAllTripDesc),
          StreamProvider<List<KotaModel>>.value(value: KotaController().getAllKota),
        ],
      child: new Scaffold(
          appBar: new AppBar(
            title: Text('Daftar Perjalanan'),
          ),
          backgroundColor: kPrimaryColor,
          body: new SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[TripList()],
                ),
              )
          ),
        floatingActionButton: new FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new FormTambahTrip())
            );
          },
          child: Icon(Icons.add, color: kPrimaryColor),
          backgroundColor: Colors.white,
        ),
        ),
    );
  }
}
