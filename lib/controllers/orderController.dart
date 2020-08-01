import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_ta/models/orderModel.dart';

class OrderController {
  final String uid;

  OrderController({this.uid});

  final CollectionReference orderCollection = Firestore.instance.collection('order');

  //List from model
  List<OrderModel> _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return OrderModel(
        idOrder: doc.documentID,
        idKota: doc.data['id_kota'],
        idToko: doc.data['id_toko'],
        idKue: doc.data['id_kue'],
        jumlahKue: doc.data['jumlah_kue'],
        namaPelanggan: doc.data['nama_pelanggan'],
        noTelpPelanggan: doc.data['no_telp_pelanggan'],
        tanggalAmbil: doc.data['tanggal_ambil'],
        tanggalPesan: doc.data['tanggal_pesan'],
        totalBiaya: doc.data['total_biaya'],
        statusOrder: doc.data['status_order'],
      );
    }).toList();
  }

  //get all data using stream
  Stream<List<OrderModel>> get getAllOrder {
    return orderCollection.snapshots()
        .map(_orderListFromSnapshot);
  }
}