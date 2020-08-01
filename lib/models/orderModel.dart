import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String idOrder;
  final String idKota;
  final String idKue;
  final String idToko;
  final int jumlahKue;
  final String namaPelanggan;
  final String noTelpPelanggan;
  final String statusOrder;
  final String tanggalAmbil;
  final Timestamp tanggalPesan;
  final int totalBiaya;

  OrderModel({this.idOrder, this.idKota, this.idKue, this.idToko, this.jumlahKue, this.namaPelanggan, this.noTelpPelanggan, this.statusOrder, this.tanggalAmbil, this.tanggalPesan, this.totalBiaya});
}