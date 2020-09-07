import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TambahKotaForm extends StatefulWidget {
  @override
  _TambahKotaFormState createState() => _TambahKotaFormState();
}

class _TambahKotaFormState extends State<TambahKotaForm> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<KotaModel>>.value(
      value: KotaController().getAllKota,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Tambah Kota'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(child: FormTambahKota()),
        ),
      ),
    );
  }
}

class FormTambahKota extends StatefulWidget {
  @override
  _FormTambahKotaState createState() => _FormTambahKotaState();
}

class _FormTambahKotaState extends State<FormTambahKota> {
  TextEditingController namaController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String namaKota = '';

  @override
  Widget build(BuildContext context) {
    var controller = KotaController();

    final kota = Provider.of<List<KotaModel>>(context);

    return Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new SizedBox(height: 20.0),
          new TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Nama kota harus Diisi';
              }
              return null;
            },
            controller: namaController,
            onChanged: (String str) {
              setState(() {
                namaKota = str;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              hintText: 'Nama Kota',
              labelText: 'Nama Kota',
            ),
          ),
          new RaisedButton(
              color: kPrimaryColor,
              child: new Text(
                'Tambah Kota',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  var _dataAda = false;

                  kota.forEach((element) {
                    if (element.namaKota == namaKota) {
                      _dataAda = true;
                    }
                  });

                  if (_dataAda) {
                    Fluttertoast.showToast(
                        msg: "Nama Kota telah terdaftar",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kPrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    await controller.tambahKota(namaKota).then((value) =>
                        Fluttertoast.showToast(
                            msg: "Berhasil Menambahkan Kota",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0));
                    Navigator.pop(context);
                  }
                }
              }),
        ],
      ),
    );
  }
}
