import 'package:app_ta/controllers/qaController.dart';
import 'package:app_ta/models/qaModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/qa/components/qaList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QAScreen extends StatefulWidget {
  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<QAModel>>.value(value: QAController().getAllQA),
      ],
      child: new Scaffold(
        appBar: new AppBar(
          title: Text('Daftar Quest and Answer'),
        ),
        backgroundColor: kPrimaryColor,
        body: new SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[QAList()],
              ),
            )
        ),
      ),
    );
  }
}
