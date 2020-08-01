import 'package:app_ta/models/tokoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TokoController {
  final String uid;

  TokoController({this.uid});

  final CollectionReference tokoCollection = Firestore.instance.collection('toko');

  List<TokoModel> _tokoListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return TokoModel(
          idToko: doc.documentID,
          idKota: doc.data['id_kota'],
          namaToko: doc.data['nama_toko'],
          gambarToko: doc.data['gambar_toko']
      );
    }).toList();
  }

  Stream<List<TokoModel>> get getAllToko {
    return tokoCollection.snapshots()
        .map(_tokoListSnapshot);
  }
}