import 'package:app_ta/controllers/qaController.dart';
import 'package:app_ta/models/qaModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FormEditQA extends StatefulWidget {
  final QAModel qa;
  FormEditQA({this.qa});

  @override
  _FormEditQAState createState() => _FormEditQAState(qa: qa);
}

class _FormEditQAState extends State<FormEditQA> {
  final QAModel qa;
  _FormEditQAState({this.qa});

  String quest = '';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    var controller = QAController();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ubah Q&A'),
        backgroundColor: kPrimaryColor,
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 20.0),
              new TextFormField(
                initialValue: qa.quest,
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
                initialValue: qa.answer,
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
                  child: new Text('Edit Q&A', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(quest == ''){
                      quest = qa.quest;
                    }

                    if(answer == '') {
                      answer = qa.answer;
                    }

                    var data = {
                      'quest' : quest,
                      'answer' : answer
                    };
                    await controller.updateData(qa.idQA,data).then((value) =>
                        Fluttertoast.showToast(
                            msg: "Berhasil mengubah data Q&A",
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
