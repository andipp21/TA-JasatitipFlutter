import 'package:app_ta/models/kotaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;

class KotaController {
  final String uid;

  KotaController({this.uid});

  final CollectionReference kotaCollection = Firestore.instance.collection('kota');

  List<KotaModel> _kotaListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return KotaModel(
        idKota: doc.documentID,
        namaKota: doc.data['nama_kota']
      );
    }).toList();
  }

  Stream<List<KotaModel>> get getAllKota {
    return kotaCollection.snapshots()
        .map(_kotaListSnapshot);
  }

  Future tambahKota(String namaKota) async {
    await kotaCollection.document().setData({
      'nama_kota': namaKota
    });
  }

  Future updateData(String id, Map data) async {
    await kotaCollection.document(id).updateData(data);
  }

  Future removeData(String id) async {
    await kotaCollection.document(id).delete();
  }
}