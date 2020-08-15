import 'package:app_ta/models/tripModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripController {
  final String uid;

  TripController({this.uid});

  final CollectionReference tripCollection = Firestore.instance.collection('trip');

  List<TripModel> _tripListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return TripModel(
          idTrip: doc.documentID,
          idKotaTujuan: doc.data['id_kota_tujuan'],
          tanggalBerangkat: doc.data['tanggal_berangkat'],
          tanggalKembali: doc.data['tanggal_kembali'],
      );
    }).toList();
  }

  Stream<List<TripModel>> get getAllTrip {
    return tripCollection.orderBy("tanggal_berangkat").snapshots()
        .map(_tripListSnapshot);
  }

  Stream<List<TripModel>> get getAllTripDesc {
    return tripCollection.orderBy("tanggal_berangkat",descending: true).snapshots()
        .map(_tripListSnapshot);
  }

  Future addData(Map data) async {
    await tripCollection.add(data);
  }

  Future updateData(String id, Map data) async {
    await tripCollection.document(id).updateData(data);
  }

  Future removeData(String id) async {
    await tripCollection.document(id).delete();
  }
}