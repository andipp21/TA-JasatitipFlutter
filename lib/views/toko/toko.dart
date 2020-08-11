import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/toko/components/tokoList.dart';
import 'package:app_ta/views/toko/crud/tambahTokoScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TokoScreen extends StatefulWidget {
  final idKota;
  final namaKota;
  TokoScreen({this.idKota, this.namaKota});

  @override
  _TokoScreenState createState() => _TokoScreenState(idKota: idKota, namaKota: namaKota);
}

class _TokoScreenState extends State<TokoScreen> {
  final idKota;
  final namaKota;

  _TokoScreenState({this.idKota, this.namaKota});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<List<TokoModel>>.value(value: TokoController().getAllToko),
        ],
        child: new Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: new AppBar(
            title: Text('Daftar toko di $namaKota'),
          ),
          backgroundColor: kPrimaryColor,
          body: new SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    children: <Widget>[
                      TokoList(idKota: idKota,)
                    ],
                  ),
                ),
              )
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new TambahTokoScreen(idKota: idKota, namaKota: namaKota,))
              );
            },
            child: Icon(Icons.add, color: kPrimaryColor),
            backgroundColor: Colors.white,
          ),
        ),
    );
  }
}
