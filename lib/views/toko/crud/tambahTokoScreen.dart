import 'dart:io';

import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TambahTokoScreen extends StatefulWidget {
  final idKota, namaKota;
  TambahTokoScreen({this.idKota, this.namaKota});

  @override
  _TambahTokoScreenState createState() => _TambahTokoScreenState(idKota: idKota, namaKota: namaKota);
}

class _TambahTokoScreenState extends State<TambahTokoScreen> {
  final idKota, namaKota;
  _TambahTokoScreenState({this.idKota,this.namaKota});

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<TokoModel>>.value(
      value: TokoController().getAllToko,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Tambah Toko'),
          backgroundColor: kPrimaryColor,
        ),
        body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: FormTambahToko(idKota: idKota,)
          ),
        ),
      ),
    );
  }
}

class FormTambahToko extends StatefulWidget {
  final idKota;
  FormTambahToko({this.idKota});
  @override
  _FormTambahTokoState createState() => _FormTambahTokoState(idKota: idKota);
}

class _FormTambahTokoState extends State<FormTambahToko> {
  final idKota;
  _FormTambahTokoState({this.idKota});

  bool _dataAda = false;

  final _formKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  final controller = TokoController();

  TextEditingController controllerNama= new TextEditingController();
  String namaToko= '';
  String imageUrl='';

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
          msg: "Nama Toko Telah Terdaftar",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else {
      if(_image == null){
        imageUrl = "noImage.jpg";
      }else{
        var imageName = namaToko+".jpg";

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
        'id_kota' : idKota,
        'nama_toko' : namaToko,
        'gambar_toko' : imageUrl
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

    final dataToko = Provider.of<List<TokoModel>>(context);

    cekDataKota(){
      dataToko.forEach((element) {
        if(element.idKota == idKota){
          if(element.namaToko == namaToko){
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
                return 'Nama toko tidak boleh kosong';
              }
              return null;
            },
            controller: controllerNama,
            onChanged: (String str) {
              setState(() {
                namaToko=str;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0)
              ),
              hintText: 'Nama Toko',
              labelText: 'Nama Toko',
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
              child: new Text('Tambah Toko', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  cekDataKota();
                  await uploadImage();
                }
              }
          ),
        ],
      ),
    );
  }
}
