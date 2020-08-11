import 'package:app_ta/models/kueModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KueController {
  final String uid;

  KueController({this.uid});

  final CollectionReference kueCollection = Firestore.instance.collection('kue');

  List<KueModel> _kueListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return KueModel(
          idKue: doc.documentID,
          idToko: doc.data['id_toko'],
          namaKue: doc.data['nama_kue'],
          gambarKue: doc.data['gambar_kue'],
          hargaKue: doc.data['harga_kue']
      );
    }).toList();
  }

  Stream<List<KueModel>> get getAllKue {
    return kueCollection.snapshots()
        .map(_kueListSnapshot);
  }

  Future addData(Map data) async {
    await kueCollection.add(data);
  }

  Future updateData(String id, Map data) async {
    await kueCollection.document(id).updateData(data);
  }

  Future removeData(String id) async {
    await kueCollection.document(id).delete();
  }
}