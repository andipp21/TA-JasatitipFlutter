import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String idTrip;
  final String idKotaTujuan;
  final Timestamp tanggalBerangkat;
  final Timestamp tanggalKembali;

  TripModel({this.idTrip, this.idKotaTujuan, this.tanggalBerangkat, this.tanggalKembali});
}