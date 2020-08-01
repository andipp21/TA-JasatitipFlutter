import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {

    final orders = Provider.of<List<OrderModel>>(context);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        }
    );
  }
}

class OrderCard extends StatelessWidget {

  final OrderModel order;
  OrderCard({this.order});

  @override
  Widget build(BuildContext context) {
    final kota = Provider.of<List<KotaModel>>(context);
    final toko = Provider.of<List<TokoModel>>(context);
    final kue = Provider.of<List<KueModel>>(context);
    String namaKota, namaToko, namaKue;

    var tanggalPesan = order.tanggalPesan.toDate();
    var tPesan = new DateFormat("dd-MM-yyyy").format(tanggalPesan);

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

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            children: [
              TableRow( children: [
                Text('Nama Pelanggan'),
                Text(' : '+order.namaPelanggan)
              ]),
              TableRow( children: [
                Text('No Telp Pelanggan'),
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
                Text('Total Pembayaran'),
                Text(' : '+order.totalBiaya.toString())
              ]),
              TableRow( children: [
                Text('Tanggal Ambil'),
                Text(' : '+order.tanggalAmbil)
              ]),
              TableRow( children: [
                Text('Tanggal Pesan Masuk'),
                Text(' : '+tPesan.toString())
              ]),
              TableRow( children: [
                Text('Status Orderan'),
                Text(' : '+order.statusOrder)
              ]),

            ],
          ),
        ),
      )
    );
  }
}

