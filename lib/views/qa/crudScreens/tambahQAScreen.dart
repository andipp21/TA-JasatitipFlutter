import 'package:app_ta/controllers/qaController.dart';
import 'package:app_ta/models/qaModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FormTambahQA extends StatefulWidget {
  @override
  _FormTambahQAState createState() => _FormTambahQAState();
}

class _FormTambahQAState extends State<FormTambahQA> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<QAModel>>.value(
      value: QAController().getAllQA,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Tambah FAQ'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(child: TambahQAForm()),
        ),
      ),
    );
  }
}

class TambahQAForm extends StatefulWidget {
  @override
  _TambahQAFormState createState() => _TambahQAFormState();
}

class _TambahQAFormState extends State<TambahQAForm> {
  TextEditingController questController = new TextEditingController();
  TextEditingController answerController = new TextEditingController();
  String quest = '';
  String answer = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = QAController();

    final qa = Provider.of<List<QAModel>>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          new SizedBox(height: 20.0),
          new TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Pertanyaan tidak boleh kosong';
              }
              return null;
            },
            controller: questController,
            onChanged: (String str) {
              setState(() {
                quest = str;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              hintText: 'Pertanyaan',
              labelText: 'Pertanyaan',
            ),
          ),
          new SizedBox(height: 20.0),
          new TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Jawaban tidak boleh kosong';
              }
              return null;
            },
            controller: answerController,
            onChanged: (String str) {
              setState(() {
                answer = str;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              hintText: 'Jawaban',
              labelText: 'Jawaban',
            ),
          ),
          new RaisedButton(
              color: kPrimaryColor,
              child: new Text(
                'Tambah Q&A',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                var data = {'quest': quest, 'answer': answer};
                await controller.addData(data).then((value) =>
                    Fluttertoast.showToast(
                        msg: "Berhasil Menambahkan Kota",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kPrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0));
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
