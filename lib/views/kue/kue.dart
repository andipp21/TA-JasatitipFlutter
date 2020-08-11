import 'package:app_ta/controllers/kueController.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/kue/components/kueList.dart';
import 'package:app_ta/views/kue/crudScreens/tambahKueScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KueScreen extends StatefulWidget {
  final idToko, namaToko;
  KueScreen({this.idToko,this.namaToko});

  @override
  _KueScreenState createState() => _KueScreenState(idToko: idToko, namaToko: namaToko);
}

class _KueScreenState extends State<KueScreen> {
  final idToko, namaToko;
  _KueScreenState({this.idToko,this.namaToko});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<KueModel>>.value(value: KueController().getAllKue),
      ],
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: Text('Daftar kue di toko $namaToko'),
        ),
        backgroundColor: kPrimaryColor,
        body: new SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  children: <Widget>[
                    KueList(idToko: idToko,)
                  ],
                ),
              ),
            )
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new FormTambahKue(idToko: idToko, namaToko: namaToko,))
            );
          },
          child: Icon(Icons.add, color: kPrimaryColor),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
