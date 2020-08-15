import 'package:app_ta/controllers/signinController.dart';
import 'package:app_ta/controllers/tripController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/trip/crudScreen/editTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  String namaKota;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () async {
        await Fluttertoast.showToast(
            msg: "Perjalanan ke $namaKota batal dihapus",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        await Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Iya"),
      onPressed: () async {
        await TripController().removeData(trip.idTrip).then((value) =>
            Fluttertoast.showToast(
                msg: "Berhasil Menghapus Perjalanan ke kota $namaKota",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: kPrimaryColor,
                textColor: Colors.white,
                fontSize: 16.0));
        await Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {

    final kota = Provider.of<List<KotaModel>>(context);
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
                          // Perform some action
                          showAlertDialog(context);
//                          await TripController().removeData(trip.idTrip).then((value) =>
//                              Fluttertoast.showToast(
//                                  msg: "Berhasil Menghapus Jadwal Perjalan",
//                                  toastLength: Toast.LENGTH_SHORT,
//                                  gravity: ToastGravity.BOTTOM,
//                                  timeInSecForIosWeb: 1,
//                                  backgroundColor: Colors.white,
//                                  textColor: kPrimaryColor,
//                                  fontSize: 16.0
//                              )
//                          );
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

