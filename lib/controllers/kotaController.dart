import 'package:app_ta/models/kotaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}