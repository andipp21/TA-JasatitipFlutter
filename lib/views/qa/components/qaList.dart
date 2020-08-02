import 'package:app_ta/models/qaModel.dart';
import 'package:flutter/material.dart';
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
            child: Table(children: [
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
          )
      ),
    );
  }
}

