import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/controllers/tripController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormTambahTrip extends StatefulWidget {
  @override
  _FormTambahTripState createState() => _FormTambahTripState();
}

class _FormTambahTripState extends State<FormTambahTrip> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider<List<KotaModel>>.value(value: KotaController().getAllKota),
        StreamProvider<List<TripModel>>.value(value: TripController().getAllTrip)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Jadwal Trip'),
          backgroundColor: kPrimaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormTrip(),
        ),
      ),
    );
  }
}

class FormTrip extends StatefulWidget {
  @override
  _FormTripState createState() => _FormTripState();
}

class _FormTripState extends State<FormTrip> {
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
    super.initState();

    tglBerangkat = "${tBerangkat.day}-${tBerangkat.month}-${tBerangkat.year}";
    tglKembali = "${tKembali.day}-${tKembali.month}-${tKembali.year}";
  }

  @override
  Widget build(BuildContext context) {

    final kota = Provider.of<List<KotaModel>>(context);
    final trip = Provider.of<List<TripModel>>(context);

    List<DropdownMenuItem> kt = [];
    kota.forEach((element) {
      kt.add(
        DropdownMenuItem(
          child: Text(element.namaKota),
          value: element.idKota,
        )
      );
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
                  value: kotaTerpilih,
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
              var _dataAda = false;

              trip.forEach((element) {
                var tanggalBerangkat = new DateFormat("dd-MM-yyyy").format(tBerangkat);
                var tanggalKembali = new DateFormat("dd-MM-yyyy").format(tKembali);
                var tripKembali = new DateFormat("dd-MM-yyyy").format(element.tanggalKembali.toDate());
                var tripBerangkat = new DateFormat("dd-MM-yyyy").format(element.tanggalBerangkat.toDate());

                if(tanggalBerangkat == tripBerangkat ||
                    tanggalBerangkat == tripKembali ||
                    tanggalKembali == tripBerangkat ||
                    tanggalKembali == tripKembali)
                {
                  _dataAda = true;
                }
              });

              if(_dataAda){
                Fluttertoast.showToast(
                    msg: "Tanggal Keberangkatan atau Kembali kamu telah ada sebelumnya",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: kPrimaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              } else {
                var data = {
                  "id_kota_tujuan" : kotaTerpilih,
                  "tanggal_berangkat" : tBerangkat,
                  "tanggal_kembali" : tKembali
                };

                await TripController().addData(data).then((value) =>
                    Fluttertoast.showToast(
                        msg: "Berhasil Menambahkan Jadwal Perjalan Baru",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kPrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0
                    ));

                Navigator.pop(context);
              }
            },
            child: Text('Tambah Jadwal Perjalanan', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}


