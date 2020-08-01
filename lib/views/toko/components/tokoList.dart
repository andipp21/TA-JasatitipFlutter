import 'package:app_ta/models/tokoModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/kue/kue.dart';
import 'package:flutter/material.dart';
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

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: toko.length,
      // ignore: missing_return
      itemBuilder: (context, i){
        if(toko[i].idKota == idKota){
           return TokoCard(toko: toko[i],);
        }
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
                      print('edit ditekan');
                    },
                    child: const Text('Edit', style: TextStyle(fontSize: 16),),
                  ),
                  FlatButton(
                    onPressed: () {
                      // Perform some action
                      print('hapus ditekan');
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

