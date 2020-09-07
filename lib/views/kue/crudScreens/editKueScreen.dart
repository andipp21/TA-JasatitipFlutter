import 'dart:io';

import 'package:app_ta/controllers/kueController.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormEditKue extends StatefulWidget {
  final KueModel kue;

  FormEditKue({this.kue});

  @override
  _FormEditKueState createState() => _FormEditKueState(kue: kue);
}

class _FormEditKueState extends State<FormEditKue> {
  final KueModel kue;

  _FormEditKueState({this.kue});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<KueModel>>.value(
      value: KueController().getAllKue,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Tambah Kue'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(child: EditKueForm(kue: kue)),
        ),
      ),
    );
  }
}

class EditKueForm extends StatefulWidget {
  final KueModel kue;

  EditKueForm({this.kue});

  @override
  _EditKueFormState createState() => _EditKueFormState(kue: kue);
}

class _EditKueFormState extends State<EditKueForm> {
  final KueModel kue;

  _EditKueFormState({this.kue});

  final _formKey = GlobalKey<FormState>();

  bool _dataAda = false;
  bool _buttonDisabled = true;

  File _image;
  final picker = ImagePicker();

  final controller = KueController();

  String namaKue = '';
  String imageUrl = '';
  String hargaKue = '0';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      _buttonDisabled = false;
    });

    print('image picked');
  }

  Future uploadImage() async {
    int hk;

    if (_dataAda) {
      Fluttertoast.showToast(
          msg: "Nama Kue Telah Terdaftar",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (namaKue == '') {
        namaKue = kue.namaKue;
      }

      if (hargaKue == '0') {
        hk = kue.hargaKue;
      } else {
        hk = int.parse(hargaKue);
      }

      if (_image != null) {
        var imageName = namaKue + ".jpg";

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
        imageUrl = kue.gambarKue;
      }

      var data = {
        'id_toko': kue.idToko,
        'nama_kue': namaKue,
        'gambar_kue': imageUrl,
        'harga_kue': hk
      };

      print(data);

      await controller.updateData(kue.idKue, data).then((value) => {
            print('save success'),
            Fluttertoast.showToast(
                msg: "Berhasil mengubah data kue",
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
    final dataKue = Provider.of<List<KueModel>>(context);

    cekDataKue() {
      dataKue.forEach((element) {
        if (element.idToko == kue.idToko) {
          if (element.namaKue == namaKue) {
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
            validator: (value) {
              if (value.isEmpty) {
                return 'Nama kue tidak boleh kosong';
              }
              return null;
            },
            initialValue: kue.namaKue,
            onChanged: (String str) {
              setState(() {
                namaKue = str;
                _buttonDisabled = false;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              hintText: 'Nama Kue',
              labelText: 'Nama Kue',
            ),
          ),
          new SizedBox(height: 20.0),
          new TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Harga kue tidak boleh kosong';
              }
              return null;
            },
            initialValue: kue.hargaKue.toString(),
            keyboardType: TextInputType.number,
            onChanged: (String str) {
              setState(() {
                hargaKue = str;
                _buttonDisabled = false;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              hintText: 'Harga Kue',
              labelText: 'Harga Kue',
            ),
          ),
          Center(
            child: _image == null
                ? Image.network(kue.gambarKue)
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
                'Ubah Kue',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _buttonDisabled
                  ? null
                  : () async {
                      if (_formKey.currentState.validate()) {
                        cekDataKue();
                        await uploadImage();
                      }
                    }),
        ],
      ),
    );
  }
}
