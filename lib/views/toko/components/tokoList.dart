import 'package:app_ta/controllers/tokoController.dart';
import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/kue/kue.dart';
import 'package:app_ta/views/toko/crud/editTokoScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TokoList extends StatefulWidget {
  final idKota;
  TokoList({this.idKota});

  @override
  _TokoListState createState() => _TokoListState(idKota: idKota);
}

class _TokoListState extends State<TokoList> {
  final idKota;
  _TokoListState({this.idKota});

  @override
  Widget build(BuildContext context) {
    final toko = Provider.of<List<TokoModel>>(context);
    var dataToko = [];
    toko.forEach((toko) {
      if(toko.idKota == idKota){
        dataToko.add(toko);
      }
    });

    print(dataToko);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataToko.length,
      // ignore: missing_return
      itemBuilder: (context, i){
        return TokoCard(toko: dataToko[i],);
      },
    );
  }
}

class TokoCard extends StatelessWidget {

  final TokoModel toko;
  TokoCard({this.toko});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        elevation: 16,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => new KueScreen(idToko: toko.idToko, namaToko: toko.namaToko,),
              ));
            },
            child: ListTile(
              leading: Image.network(toko.gambarToko, fit: BoxFit.fill),
              title: Text(
                toko.namaToko,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    textColor: kPrimaryColor,
                    onPressed: () {
                      // Perform some action
                      Navigator.of(context).push(
                          new MaterialPageRoute(builder: (context) => new EditTokoForm(toko: toko))
                      );
                    },
                    child: const Text('Edit', style: TextStyle(fontSize: 16),),
                  ),
                  FlatButton(
                    onPressed: () {
                      // Perform some action
                      TokoController().removeData(toko.idToko).then((value) =>
                          Fluttertoast.showToast(
                              msg: "Berhasil Menghapus Kota",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: kPrimaryColor,
                              fontSize: 16.0
                          )
                      );
                    },
                    child: const Text('Hapus', style: TextStyle(fontSize: 16),),
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}

