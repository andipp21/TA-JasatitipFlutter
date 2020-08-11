import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/kota/components/kotaList.dart';
import 'package:app_ta/views/kota/crudScreens/tambahKotaScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KotaScreen extends StatefulWidget {
  @override
  _KotaScreenState createState() => _KotaScreenState();
}

class _KotaScreenState extends State<KotaScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [StreamProvider<List<KotaModel>>.value(value: KotaController().getAllKota)],
      child: new Scaffold(
        appBar: new AppBar(
          title: Text('Daftar Kota'),
        ),
        backgroundColor: kPrimaryColor,
        body: new SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  KotaList(),
                ],
              ),
            )
        ),
        floatingActionButton: new FloatingActionButton(
            onPressed: (){
              Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new TambahKotaForm())
              );
            },
            child: Icon(Icons.add, color: kPrimaryColor),
            backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
