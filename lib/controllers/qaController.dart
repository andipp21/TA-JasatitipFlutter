import 'package:app_ta/models/qaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QAController {
  final String uid;

  QAController({this.uid});

  final CollectionReference qaCollection = Firestore.instance.collection('qa');

  List<QAModel> _qaListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) {
      return QAModel(
          idQA: doc.documentID,
          quest: doc.data['quest'],
          answer: doc.data['answer']
      );
    }).toList();
  }

  Stream<List<QAModel>> get getAllQA {
    return qaCollection.snapshots()
        .map(_qaListSnapshot);
  }
}