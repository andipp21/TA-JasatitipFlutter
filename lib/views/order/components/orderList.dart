import 'package:app_ta/controllers/orderController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  final String status;
  OrderList({this.status});
  @override
  _OrderListState createState() => _OrderListState(status: status);
}

class _OrderListState extends State<OrderList> {
  final String status;
  _OrderListState({this.status});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<OrderModel>>(context);

    var dataOrder = [];

    orders.forEach((order) {
      if(order.statusOrder == status){
        dataOrder.add(order);
        print(order.tanggalPesan.toDate().toString());
      }
    });


    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: dataOrder.length,
        itemBuilder: (context, index) {
          return OrderCard(order: dataOrder[index]);
        }
    );
  }
}

class OrderCard extends StatelessWidget {

  final OrderModel order;
  OrderCard({this.order});

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
    final toko = Provider.of<List<TokoModel>>(context);
    final kue = Provider.of<List<KueModel>>(context);
    String namaKota, namaToko, namaKue;

    String status1 = "Order Sedang di Konfirmasi";
    String status2 = "Order Akan di Belikan";
    String status3 = "Order Dapat di Ambil";

    var tanggalPesan = order.tanggalPesan.toDate();
    var tPesan = changeTanggal(tanggalPesan);



    kota.forEach((element) {
      if(element.idKota == order.idKota){
        namaKota = element.namaKota;
      }
    });

    toko.forEach((element) {
      if(element.idToko == order.idToko){
        namaToko = element.namaToko;
      }
    });

    kue.forEach((element) {
          if(element.idKue == order.idKue){
            namaKue = element.namaKue;
          }
        });

    var _button;
    if(order.statusOrder == status1){
      _button = FlatButton(
        color: kPrimaryColor,
        textColor: Colors.white,
        onPressed: () async {
          var data = {
            'status_order' : status2
          };
          // Perform some action
          await OrderController().updateData(order.idOrder, data);
        },
        child: Text("Konfirmasi kue akan dibelikan", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,),
      );
    } else if (order.statusOrder == status2){
      _button = FlatButton(
          color: kPrimaryColor,
          textColor: Colors.white,
          onPressed: () async {
            var data = {
              'status_order' : status3
            };
            // Perform some action
            await OrderController().updateData(order.idOrder, data);
          },
          child: Text("Konfirmasi kue telah dibeli", style: TextStyle(fontSize: 16), textAlign: TextAlign.center)
      );
    } else {
      _button = null;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Table(
                columnWidths: {
                  0: FlexColumnWidth(0.7),
                  1: FlexColumnWidth(1.0),// i want this one to take the rest available space
                },
                children: [
                  TableRow( children: [
                    Text('Nama Pelanggan'),
                    Text(' : '+order.namaPelanggan),
                  ]),
                  TableRow( children: [
                    Text('No Telp'),
                    Text(' : '+order.noTelpPelanggan)
                  ]),
                  TableRow( children: [
                    Text('ID Order'),
                    Text(' : '+order.idOrder)
                  ]),
                  TableRow( children: [
                    Text('Nama Kota'),
                    Text(' : '+namaKota)
                  ]),
                  TableRow( children: [
                    Text('Nama Toko'),
                    Text(' : '+namaToko)
                  ]),
                  TableRow( children: [
                    Text('Nama Kue'),
                    Text(' : '+namaKue)
                  ]),
                  TableRow( children: [
                    Text('Jumlah Kue'),
                    Text(' : '+order.jumlahKue.toString())
                  ]),
                  TableRow( children: [
                    Text('Total Biaya'),
                    Text(' : '+order.totalBiaya.toString())
                  ]),
                  TableRow( children: [
                    Text('Tanggal Ambil'),
                    Text(' : '+order.tanggalAmbil)
                  ]),
                  TableRow( children: [
                    Text('Tanggal Pesan'),
                    Text(' : '+tPesan.toString())
                  ]),
                  TableRow( children: [
                    Text('Status Orderan'),
                    Text(' : '+order.statusOrder)
                  ]),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  _button
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}

