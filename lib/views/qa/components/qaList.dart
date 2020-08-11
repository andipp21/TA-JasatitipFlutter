import 'package:app_ta/controllers/qaController.dart';
import 'package:app_ta/models/qaModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/qa/crudScreens/editQAScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class QAList extends StatefulWidget {
  @override
  _QAListState createState() => _QAListState();
}

class _QAListState extends State<QAList> {
  @override
  Widget build(BuildContext context) {
    final qa = Provider.of<List<QAModel>>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: qa.length,
      itemBuilder: (context, i){
        return QATile(qa: qa[i]);
      },
    );
  }
}

class QATile extends StatelessWidget {
  final QAModel qa;
  QATile({this.qa});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Table(children: [
                  TableRow(
                      children: [
                    Text('Quest'),
                    Text(': ${qa.quest}')
                  ]),
                  TableRow(children: [
                    Text('Answer'),
                    Text(': ${qa.answer}', textAlign: TextAlign.justify,)
                  ]),
                ],
                columnWidths: {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(1.0),// i want this one to take the rest available space
                },
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      textColor: kPrimaryColor,
                      onPressed: () {
                        // Perform some action
                        Navigator.of(context).push(
                            new MaterialPageRoute(builder: (context) => new FormEditQA(qa: qa,))
                        );
                      },
                      child: const Text('Edit', style: TextStyle(fontSize: 16),),
                    ),
                    FlatButton(
                      onPressed: () {
                        // Perform some action
                        QAController().removeData(qa.idQA).then((value) =>
                            Fluttertoast.showToast(
                                msg: "Berhasil Menghapus QA",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kPrimaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            )
                        );
                      },
                      child: const Text('Hapus', style: TextStyle(fontSize: 16),),
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}

