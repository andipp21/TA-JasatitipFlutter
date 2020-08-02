import 'package:app_ta/models/tripModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripBulanIni extends StatefulWidget {
  @override
  _TripBulanIniState createState() => _TripBulanIniState();
}

class _TripBulanIniState extends State<TripBulanIni> {
  @override
  Widget build(BuildContext context) {
    final trip = Provider.of<List<TripModel>>(context);

    var dataTrip = [];

    var bulanIni = DateTime.now().month;

    trip.forEach((trip) {
      var bulanBerangkat = trip.tanggalBerangkat.toDate().month;
      if(bulanBerangkat == bulanIni){
        dataTrip.add(trip);
      }
    });

    return Container();
  }
}
