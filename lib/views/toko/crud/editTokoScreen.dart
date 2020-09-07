import 'dart:io';

import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditTokoForm extends StatefulWidget {
  final TokoModel toko;
  final String namaKota;

  EditTokoForm({this.toko, this.namaKota});

  @override
  _EditTokoFormState createState() =>
      _EditTokoFormState(toko: toko, namaKota: namaKota);
}

class _EditTokoFormState extends State<EditTokoForm> {
  final TokoModel toko;
  final String namaKota;

  _EditTokoFormState({this.toko, this.namaKota});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TokoModel>>.value(
      value: TokoController().getAllToko,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Ubah Data Toko'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(child: TokoEditForm(toko: toko)),
        ),
      ),
    );
  }
}

class TokoEditForm extends StatefulWidget {
  final TokoModel toko;

  TokoEditForm({this.toko});

  @override
  _TokoEditFormState createState() => _TokoEditFormState(toko: toko);
}

class _TokoEditFormState extends State<TokoEditForm> {
  final TokoModel toko;

  _TokoEditFormState({this.toko});

  bool _buttonDisabled = true;
  bool _dataAda = false;

  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  final controller = TokoController();

  TextEditingController controllerNama = new TextEditingController();
  String namaToko = '';
  String imageUrl = '';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _buttonDisabled = false;
    });

    print('image picked');
  }

  Future uploadImage() async {
    if (_dataAda) {
      Fluttertoast.showToast(
          msg: "Nama Toko Telah Terdaftar",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (namaToko == '') {
        namaToko = toko.namaToko;
      }

      if (_image != null) {
        var imageName = namaToko + ".jpg";

        StorageReference ref =
            FirebaseStorage.instance.ref().child('toko/$imageName');
        StorageUploadTask uploadTask = ref.putFile(_image);

        await uploadTask.onComplete;
        await ref.getDownloadURL().then((url) {
          setState(() {
            imageUrl = url.toString();
          });
        });
      } else {
        imageUrl = toko.gambarToko;
      }

      var data = {
        'id_kota': toko.idKota,
        'nama_toko': namaToko,
        'gambar_toko': imageUrl
      };

      print(data);

      await controller.updateData(toko.idToko, data).then((value) => {
            print('save success'),
            Fluttertoast.showToast(
                msg: "Berhasil Mengubah Data Toko",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: kPrimaryColor,
                textColor: Colors.white,
                fontSize: 16.0)
          });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataToko = Provider.of<List<TokoModel>>(context);

    cekDataKota() {
      dataToko.forEach((element) {
        if (element.idKota == toko.idKota) {
          if (element.namaToko == namaToko) {
            _dataAda = true;
          }
        }
      });
      return _dataAda;
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          new SizedBox(height: 20.0),
          new TextFormField(
            initialValue: toko.namaToko,
            validator: (value) {
              if (value.isEmpty) {
                return 'Nama toko tidak boleh kosong';
              }
              return null;
            },
            onChanged: (String str) {
              setState(() {
                namaToko = str;
                _buttonDisabled = false;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              hintText: 'Nama Toko',
              labelText: 'Nama Toko',
            ),
          ),
          Center(
            child: _image == null
                ? Image.network(toko.gambarToko)
                : Image.file(_image),
          ),
          RaisedButton(
            child: Icon(Icons.image),
            onPressed: () {
              getImage();
            },
          ),
          RaisedButton(
              color: kPrimaryColor,
              child: new Text(
                'Ubah Toko',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _buttonDisabled
                  ? null
                  : () async {
                      if (_formKey.currentState.validate()) {
                        cekDataKota();
                        await uploadImage();
                      }
                    }),
        ],
      ),
    );
  }
}
