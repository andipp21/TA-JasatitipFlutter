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

  TextEditingController namaController = new TextEditingController();
  String namaKota='';

  @override
  Widget build(BuildContext context) {
    var controller = KotaController();

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
                controller: namaController,
                onChanged: (String str) {
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
                  child: new Text('Tambah Kota', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    await controller.tambahKota(namaKota).then((value) =>
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
