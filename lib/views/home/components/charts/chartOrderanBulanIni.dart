import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartOrderBulanIni extends StatefulWidget {
  @override
  _ChartOrderBulanIniState createState() => _ChartOrderBulanIniState();
}

class _ChartOrderBulanIniState extends State<ChartOrderBulanIni> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<OrderModel>>(context);
    final kota = Provider.of<List<KotaModel>>(context);
    var orderan = [];

    var bulanIni = DateTime.now().month;

    kota.forEach((kota) {
      int jumlah = 0;
      order.forEach((order) {
        var bulanPesan = order.tanggalPesan.toDate().month;
        if(bulanPesan==bulanIni){
          if(kota.idKota == order.idKota){
            jumlah++;
          }
        }
      });
      var data = {
        'nama' : kota.namaKota,
        'jumlah' : jumlah
      };
      orderan.add(data);
    });

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Nama Kota',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Jumlah Orderan',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: orderan.map((data) => DataRow(
          cells: [
            DataCell(Text(data['nama'])),
            DataCell(Text(data['jumlah'].toString()))
          ]
      )
      ).toList()
    );
  }
}
