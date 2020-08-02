import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  @override
  Widget build(BuildContext context) {
    final trip = Provider.of<List<TripModel>>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: trip.length,
      itemBuilder: (context, i){
        return TripTile(trip: trip[i]);
      },
    );
  }
}

class TripTile extends StatelessWidget {
  final TripModel trip;
  TripTile({this.trip});

  @override
  Widget build(BuildContext context) {

    final kota = Provider.of<List<KotaModel>>(context);
    String namaKota;
    var tBerangkat = trip.tanggalBerangkat.toDate();
    var tKembali = trip.tanggalKembali.toDate();
    var tanggalBerangakat = new DateFormat("dd-MM-yyyy").format(tBerangkat);
    var tanggalKembali = new DateFormat("dd-MM-yyyy").format(tKembali);

    kota.forEach((element) {
      if(element.idKota == trip.idKotaTujuan){
        namaKota = element.namaKota;
      }
    });

    return Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
          elevation: 8,
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Table(children: [
                  TableRow(children: [
                    Text('Kota Tujuan'),
                    Text(': $namaKota')
                  ]),
                  TableRow(children: [
                    Text('Tanggal Berangkat'),
                    Text(': $tanggalBerangakat')
                  ]),
                  TableRow(children: [
                    Text('Tanggal Kembali'),
                    Text(': $tanggalKembali')
                  ]),
              ]),
          )
        ),
    );
  }
}

