import 'package:app_ta/controllers/tripController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/trip/crudScreen/editTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';import 'package:provider/provider.dart';

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

// ignore: must_be_immutable
class TripTile extends StatelessWidget {
  final TripModel trip;
  TripTile({this.trip});

  String namaKota;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () async {
        await Fluttertoast.showToast(
            msg: "Perjalanan ke $namaKota batal dihapus",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Iya"),
      onPressed: () async {
        await TripController().removeData(trip.idTrip).then((value) =>
            Fluttertoast.showToast(
                msg: "Berhasil Menghapus Perjalanan ke kota $namaKota",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: kPrimaryColor,
                textColor: Colors.white,
                fontSize: 16.0));
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Kamu Yakin?"),
      content: Text(
          "Data jadwal perjalanan ke $namaKota akan terhapus"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  changeTanggal(DateTime date){
    var tahun = date.year;
    var bulan = '';
    var tanggal = date.day;
    var hari = '';

    switch(date.weekday) {
      case 0: hari = "Minggu"; break;
      case 1: hari = "Senin"; break;
      case 2: hari = "Selasa"; break;
      case 3: hari = "Rabu"; break;
      case 4: hari = "Kamis"; break;
      case 5: hari = "Jum'at"; break;
      case 6: hari = "Sabtu"; break;
    }
    switch(date.month) {
      case 0: bulan = "Januari"; break;
      case 1: bulan = "Februari"; break;
      case 2: bulan = "Maret"; break;
      case 3: bulan = "April"; break;
      case 4: bulan = "Mei"; break;
      case 5: bulan = "Juni"; break;
      case 6: bulan = "Juli"; break;
      case 7: bulan = "Agustus"; break;
      case 8: bulan = "September"; break;
      case 9: bulan = "Oktober"; break;
      case 10: bulan = "November"; break;
      case 11: bulan = "Desember"; break;
    }

    return '$hari, $tanggal $bulan $tahun';
  }

  @override
  Widget build(BuildContext context) {

    final kota = Provider.of<List<KotaModel>>(context);
    var tBerangkat = trip.tanggalBerangkat.toDate();
    var tKembali = trip.tanggalKembali.toDate();
    var tanggalBerangakat = changeTanggal(tBerangkat);
    var tanggalKembali = changeTanggal(tKembali);

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
              child: Column(
                children: <Widget>[
                  Table(children: [
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
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        textColor: kPrimaryColor,
                        onPressed: () {
                          // Perform some action
                          Navigator.of(context).push(
                              new MaterialPageRoute(builder: (context) => new FormEditTrip(trip: trip, namaKota: namaKota,))
                          );
                        },
                        child: const Text('Edit', style: TextStyle(fontSize: 16),),
                      ),
                      FlatButton(
                        onPressed: () async {
                          showAlertDialog(context);
                        },
                        child: const Text('Hapus', style: TextStyle(fontSize: 16),),
                        textColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
          )
        ),
    );
  }
}

