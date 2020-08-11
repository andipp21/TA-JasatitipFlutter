import 'dart:io';

import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class TambahTokoScreen extends StatefulWidget {
  final idKota, namaKota;
  TambahTokoScreen({this.idKota, this.namaKota});

  @override
  _TambahTokoScreenState createState() => _TambahTokoScreenState(idKota: idKota, namaKota: namaKota);
}

class _TambahTokoScreenState extends State<TambahTokoScreen> {
  final idKota, namaKota;
  _TambahTokoScreenState({this.idKota, this.namaKota});

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
    var imageName = namaToko+".jpg";
    
    StorageReference ref = FirebaseStorage.instance.ref().child('toko/$imageName');
    StorageUploadTask uploadTask = ref.putFile(_image);

    await uploadTask.onComplete;
    await ref.getDownloadURL().then((url) {
      setState(() {
        imageUrl = url.toString();
      });
    });


    print(imageName);
    print(imageUrl);

    var data = {
      'id_kota' : idKota,
      'nama_toko' : namaToko,
      'gambar_toko' : imageUrl
    };

    print(data);

    await controller.addData(data).then((value) => {
        print('save success'),
        Fluttertoast.showToast(
            msg: "Berhasil Menambahkan Toko",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0
        )}
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tambah Toko'),
        backgroundColor: kPrimaryColor,
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(height: 20.0),
              new TextFormField(
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
                    await uploadImage();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
