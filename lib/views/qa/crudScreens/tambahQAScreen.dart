import 'package:app_ta/controllers/qaController.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FormTambahQA extends StatefulWidget {
  @override
  _FormTambahQAState createState() => _FormTambahQAState();
}

class _FormTambahQAState extends State<FormTambahQA> {
  TextEditingController questController = new TextEditingController();
  TextEditingController answerController = new TextEditingController();
  String quest = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    var controller = QAController();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tambah Kota'),
        backgroundColor: kPrimaryColor,
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 20.0),
              new TextFormField(
                controller: questController,
                onChanged: (String str) {
                  setState(() {
                    quest=str;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                  ),
                  hintText: 'Pertanyaan',
                  labelText: 'Quest',
                ),
              ),
              new SizedBox(height: 20.0),
              new TextFormField(
                controller: answerController,
                onChanged: (String str) {
                  setState(() {
                    answer=str;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0)
                  ),
                  hintText: 'Jawaban',
                  labelText: 'Answer',
                ),
              ),
              new RaisedButton(
                  color: kPrimaryColor,
                  child: new Text('Tambah Q&A', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    var data = {
                      'quest' : quest,
                      'answer' : answer
                    };
                    await controller.addData(data).then((value) =>
                        Fluttertoast.showToast(
                            msg: "Berhasil Menambahkan Kota",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0
                        )
                    );
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
