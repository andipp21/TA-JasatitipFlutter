import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditKotaForm extends StatefulWidget {
  final KotaModel kota;
  EditKotaForm({this.kota});

  @override
  _EditKotaFormState createState() => _EditKotaFormState(kota: kota);
}

class _EditKotaFormState extends State<EditKotaForm> {
  final KotaModel kota;
  _EditKotaFormState({this.kota});

  String namaKota='';

  Widget build(BuildContext context) {

    var controller = KotaController();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ubah nama kota ${kota.namaKota}'),
        backgroundColor: kPrimaryColor,
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 20.0),
              new TextFormField(
                initialValue: kota.namaKota,
                onChanged: (str) {
                  setState(() {
                    namaKota=str;
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
                  child: new Text('Edit Kota', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    var data;
                    if(namaKota == '') {
                      data = {
                        'nama_kota' : kota.namaKota
                      };
                    } else {
                      data = {
                        'nama_kota' : namaKota
                      };
                    }
                    await controller.updateData(kota.idKota,data).then((value) =>
                        Fluttertoast.showToast(
                            msg: "Berhasil Mengubah Nama Kota",
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
