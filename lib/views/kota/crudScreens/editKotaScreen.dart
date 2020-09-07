import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditKotaForm extends StatefulWidget {
  final KotaModel kota;
  EditKotaForm({this.kota});

  @override
  _EditKotaFormState createState() => _EditKotaFormState(kota: kota);
}

class _EditKotaFormState extends State<EditKotaForm> {
  final KotaModel kota;
  _EditKotaFormState({this.kota});

  Widget build(BuildContext context) {

    return StreamProvider<List<KotaModel>>.value(
      value: KotaController().getAllKota,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Ubah nama kota ${kota.namaKota}'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: FormEditKota(kota: kota,)
          ),
        ),
      ),
    );
  }
}

class FormEditKota extends StatefulWidget {
  final KotaModel kota;
  FormEditKota({this.kota});
  @override
  _FormEditKotaState createState() => _FormEditKotaState(kota: kota);
}

class _FormEditKotaState extends State<FormEditKota> {
  final KotaModel kota;
  _FormEditKotaState({this.kota});

  String namaKota='';
  bool _buttonDisabled;

  final _formKey = GlobalKey<FormState>();

  void initState(){
    _buttonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {

    var controller = KotaController();

    final dataKota = Provider.of<List<KotaModel>>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          new SizedBox(height: 20.0),
          new TextFormField(
            initialValue: kota.namaKota,
            validator: (value){
              if(value.isEmpty){
                return 'Nama kota tidak boleh kosong';
              }
              return null;
            },
            onChanged: (str) {
              setState(() {
                namaKota=str;
                _buttonDisabled = false;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)
              ),
              hintText: 'Nama Kota',
              labelText: 'Nama Kota',
            ),
          ),
          new RaisedButton(
              color: kPrimaryColor,
              child: new Text('Ubah Kota', style: TextStyle(color: Colors.white),),
              onPressed: _buttonDisabled ? null : () async {
                if(_formKey.currentState.validate()){
                  var _dataAda = false;

                  dataKota.forEach((element) {
                    if(element.namaKota == namaKota){
                      _dataAda = true;
                    }
                  });

                  if(_dataAda) {
                    Fluttertoast.showToast(
                        msg: "Nama Kota telah terdaftar",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kPrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }else{
                    var data = {
                      'nama_kota' : namaKota
                    };
                    await controller.updateData(kota.idKota,data).then((value) =>
                        Fluttertoast.showToast(
                            msg: "Berhasil Mengubah Nama Kota",
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

