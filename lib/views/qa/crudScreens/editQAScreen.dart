import 'package:app_ta/controllers/qaController.dart';
import 'package:app_ta/models/qaModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FormEditQA extends StatefulWidget {
  final QAModel qa;
  FormEditQA({this.qa});

  @override
  _FormEditQAState createState() => _FormEditQAState(qa: qa);
}

class _FormEditQAState extends State<FormEditQA> {
  final QAModel qa;
  _FormEditQAState({this.qa});

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<QAModel>>.value(
      value: QAController().getAllQA,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Ubah Q&A'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: EditQAForm(qa: qa,)
          ),
        ),
      ),
    );
  }
}

class EditQAForm extends StatefulWidget {
  final QAModel qa;
  EditQAForm({this.qa});

  @override
  _EditQAFormState createState() => _EditQAFormState(qa: qa);
}

class _EditQAFormState extends State<EditQAForm> {
  final QAModel qa;
  _EditQAFormState({this.qa});

  String quest = '';
  String answer = '';

  bool _buttonDisabled;

  final _formKey = GlobalKey<FormState>();

  void initState(){
    _buttonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    var controller = QAController();

    final dataQA = Provider.of<List<QAModel>>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          new SizedBox(height: 20.0),
          new TextFormField(
            initialValue: qa.quest,
            validator: (value){
              if(value.isEmpty){
                return 'Pertanyaan tidak boleh kosong';
              }
              return null;
            },
            onChanged: (String str) {
              setState(() {
                quest=str;
                _buttonDisabled = false;
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
            validator: (value){
              if(value.isEmpty){
                return 'Jawaban tidak boleh kosong';
              }
              return null;
            },
            onChanged: (String str) {
              setState(() {
                answer=str;
                _buttonDisabled = false;
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
              onPressed: _buttonDisabled ? null : () async {
                if(_formKey.currentState.validate()){
                  var _dataAda = false;

                  dataQA.forEach((element) {
                    if(element.quest == quest){
                      _dataAda = true;
                    }
                  });

                  if (_dataAda) {
                    Fluttertoast.showToast(
                        msg: "Pertanyaan tersebut telah ada sebelumnya",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kPrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
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
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0
                        )
                    );
                    Navigator.pop(context);
                  }
                }
              }
          ),
        ],
      ),
    );
  }
}

