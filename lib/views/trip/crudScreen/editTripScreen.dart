import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/controllers/tripController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FormEditTrip extends StatefulWidget {
  final TripModel trip;
  final String namaKota;
  FormEditTrip({this.trip, this.namaKota});

  @override
  _FormEditTripState createState() => _FormEditTripState(trip: trip, namaKota: namaKota);
}

class _FormEditTripState extends State<FormEditTrip> {
  final TripModel trip;
  final String namaKota;
  _FormEditTripState({this.trip, this.namaKota});
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<KotaModel>>.value(
      value: KotaController().getAllKota,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ubah Jadwal Trip'),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormEdit(trip: trip, namaKota: namaKota,),
        ),
      ),
    );
  }
}

class FormEdit extends StatefulWidget {
  final TripModel trip;
  final String namaKota;
  FormEdit({this.trip, this.namaKota});
  @override
  _FormEditState createState() => _FormEditState(trip: trip,nKota: namaKota);
}

class _FormEditState extends State<FormEdit> {
  final TripModel trip;
  final String nKota;
  _FormEditState({this.trip, this.nKota});

  var kotaTerpilih;

  var tBerangkat = DateTime.now();
  var tKembali = DateTime.now();

  String tglBerangkat = '';
  String tglKembali = '';

  Future<Null> pilihTanggalBerangkat (BuildContext context) async {
    final pilih = await showDatePicker(
        context: context,
        initialDate: tBerangkat,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100)
    );

    if(pilih != null){
      setState(() {
        tBerangkat=pilih;
        tglBerangkat = "${pilih.day}-${pilih.month}-${pilih.year}";
      });
    }
  }

  Future<Null> pilihTanggalKembali (BuildContext context) async {
    final pilih = await showDatePicker(
        context: context,
        initialDate: tKembali,
        firstDate: DateTime(2019),
        lastDate: DateTime(2100)
    );

    if(pilih != null){
      setState(() {
        tKembali=pilih;
        tglKembali = "${pilih.day}-${pilih.month}-${pilih.year}";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    kotaTerpilih = nKota;
    tBerangkat = trip.tanggalBerangkat.toDate();
    tKembali = trip.tanggalKembali.toDate();

    tglBerangkat = "${tBerangkat.day}-${tBerangkat.month}-${tBerangkat.year}";
    tglKembali = "${tKembali.day}-${tKembali.month}-${tKembali.year}";
  }

  @override
  Widget build(BuildContext context) {

    final kota = Provider.of<List<KotaModel>>(context);

    List<DropdownMenuItem> kt = [];

    var idKota = "";

    kota.forEach((element) {
      kt.add(
          DropdownMenuItem(
            child: Text(element.namaKota),
            value: element.idKota,
          )
      );

      if (element.namaKota == nKota){
        idKota = element.idKota;
      }
    });

    return Form(
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text("Kota Tujuan")),
              SizedBox(height: 20.0,),
              DropdownButton(
                items: kt,
                onChanged: (kotaSekarang) {
                  setState(() {
                    kotaTerpilih = kotaSekarang;
                  });
                },
                value: kotaTerpilih != null ? kotaTerpilih: idKota,
                isExpanded: false,
                hint: Text('Pilih Kota Tujiuan'),
              )
            ],
          ),
          SizedBox(height: 20.0,),
          Row(
            children: <Widget>[
              Expanded(child: Text("Tanggal Berangkat")),
              FlatButton(
                  onPressed: () => pilihTanggalBerangkat(context),
                  child: Text(tglBerangkat)
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text("Tanggal Kembali")),
              FlatButton(
                  onPressed: () => pilihTanggalKembali(context),
                  child: Text(tglKembali)
              ),
            ],
          ),
          RaisedButton(
            color: kPrimaryColor,
            onPressed: () async {

              if(kotaTerpilih ==  null){
                kotaTerpilih = trip.idKotaTujuan;
              }

              if(tBerangkat == null){
                tBerangkat = trip.tanggalBerangkat.toDate();
              }

              if(tKembali == null){
                tKembali = trip.tanggalKembali.toDate();
              }

              var data = {
                "id_kota_tujuan" : kotaTerpilih,
                "tanggal_berangkat" : tBerangkat,
                "tanggal_kembali" : tKembali
              };

              print(data);

              await TripController().updateData(trip.idTrip, data).then((value) =>
                  Fluttertoast.showToast(
                      msg: "Berhasil Mengubah data Jadwal Perjalan",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: kPrimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0
                  )
              );
              await Navigator.pop(context);
            },
            child: Text('Tambah Jadwal Perjalanan', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }


}


