import 'dart:io';

import 'package:app_ta/controllers/kueController.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormTambahKue extends StatefulWidget {
  final idToko, namaToko;
  FormTambahKue({this.idToko,this.namaToko});
  @override
  _FormTambahKueState createState() => _FormTambahKueState(idToko: idToko, namaToko: namaToko);
}

class _FormTambahKueState extends State<FormTambahKue> {
  final idToko, namaToko;
  _FormTambahKueState({this.idToko, this.namaToko});

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
          child: SingleChildScrollView(
            child: TambahKueForm(idToko: idToko)
          ),
        ),
      ),
    );
  }
}

class TambahKueForm extends StatefulWidget {
  final idToko;
  TambahKueForm({this.idToko});
  @override
  _TambahKueFormState createState() => _TambahKueFormState(idToko: idToko);
}

class _TambahKueFormState extends State<TambahKueForm> {
  final idToko;
  _TambahKueFormState({this.idToko});

  final _formKey = GlobalKey<FormState>();

  bool _dataAda = false;

  File _image;
  final picker = ImagePicker();

  final controller = KueController();

  TextEditingController controllerNama= new TextEditingController();
  TextEditingController controllerHarga= new TextEditingController();
  String namaKue= '';
  String imageUrl='';
  String hargaKue = '0';

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });

    print('image picked');
  }

  Future uploadImage() async{
    if(_dataAda){
      Fluttertoast.showToast(
          msg: "Nama Kue Telah Terdaftar",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      if(_image==null){
        imageUrl = "noImage.jpg";
      } else {
        var imageName = namaKue+".jpg";

        StorageReference ref = FirebaseStorage.instance.ref().child('toko/$imageName');
        StorageUploadTask uploadTask = ref.putFile(_image);

        await uploadTask.onComplete;
        await ref.getDownloadURL().then((url) {
          setState(() {
            imageUrl = url.toString();
          });
        });
      }

      var data = {
        'id_toko': idToko,
        'nama_kue': namaKue,
        'gambar_kue': imageUrl,
        'harga_kue': int.parse(hargaKue)
      };

      await controller.addData(data).then((value) => {
        print('save success'),
        Fluttertoast.showToast(
            msg: "Berhasil Menambahkan Toko",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        )}
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    final dataKue = Provider.of<List<KueModel>>(context);

    cekDataKue(){
      dataKue.forEach((element) {
        if(element.idToko == idToko){
          if(element.namaKue == namaKue){
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
              validator: (value){
                if(value.isEmpty){
                  return 'Nama kue tidak boleh kosong';
                }
                return null;
              },
              controller: controllerNama,
              onChanged: (String str) {
                setState(() {
                  namaKue=str;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                ),
                hintText: 'Nama Kue',
                labelText: 'Nama Kue',
              ),
            ),
            new SizedBox(height: 20.0),
            new TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'Harga kue tidak boleh kosong';
                }
                return null;
              },
              controller: controllerHarga,
              keyboardType: TextInputType.number,
              onChanged: (String str) {
                setState(() {
                  hargaKue=str;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                ),
                hintText: 'Harga Kue',
                labelText: 'Harga Kue',
              ),
            ),
            Center(
              child: _image == null? Text('Tidak ada gambar') : Image.file(_image),
            ),
            RaisedButton(
              child: Icon(Icons.image),
              onPressed: (){
                getImage();
              },
            ),
            RaisedButton(
                color: kPrimaryColor,
                child: new Text('Tambah Kue', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    cekDataKue();
                    await uploadImage();
                  }
                }
            ),
          ],
        ),
    );
  }
}

