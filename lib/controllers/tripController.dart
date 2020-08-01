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
    return tripCollection.snapshots()
        .map(_tripListSnapshot);
  }
}