import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/tripModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TripBulanIni extends StatefulWidget {
  @override
  _TripBulanIniState createState() => _TripBulanIniState();
}

class _TripBulanIniState extends State<TripBulanIni> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final trip = Provider.of<List<TripModel>>(context);
    final kota = Provider.of<List<KotaModel>>(context);

    var dataTrip = [];
    var data;

    var bulanIni = DateTime.now().month;

    trip.forEach((trip) {
      var bulanBerangkat = trip.tanggalBerangkat.toDate().month;
      if (bulanBerangkat == bulanIni) {
        kota.forEach((kota) {
          if (kota.idKota == trip.idKotaTujuan) {
            var tb = trip.tanggalBerangkat.toDate();
            var tanggalBerangakat = new DateFormat("dd-MM-yyyy").format(tb);
            var tk = trip.tanggalKembali.toDate();
            var tanggalKembali = new DateFormat("dd-MM-yyyy").format(tk);
            data = {
              'kota': kota.namaKota,
              'tanggalBerangkat': tanggalBerangakat,
              'tanggalKembali': tanggalKembali
            };
            dataTrip.add(data);
          }
        });
      }
    });

    print(dataTrip);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        child: Column(
          children: <Widget>[
            Text('Daftar Perjalanan Bulan Ini', textAlign: TextAlign.center, style: TextStyle(color: kPrimaryColor),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Kota Tujuan',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Berangkat',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Kembali',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  rows: dataTrip
                      .map((data) =>
                      DataRow(cells: [
                            DataCell(Text(data['kota'])),
                            DataCell(Text(data['tanggalBerangkat'])),
                            DataCell(Text(data['tanggalKembali']))
                          ]))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
