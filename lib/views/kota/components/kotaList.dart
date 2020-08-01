import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/toko/toko.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KotaList extends StatefulWidget {
  @override
  _KotaListState createState() => _KotaListState();
}

class _KotaListState extends State<KotaList> {
  @override
  Widget build(BuildContext context) {
    final kota = Provider.of<List<KotaModel>>(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: kota.length,
      itemBuilder: (context, i){
        return KotaTile(kota: kota[i]);
      },
    );
  }
}

class KotaTile extends StatelessWidget {
  final KotaModel kota;
  KotaTile({this.kota});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        elevation: 4,
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(child: FlatButton(
                child: Text(kota.namaKota, style: TextStyle(fontSize: 16, color: kPrimaryColor), ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new TokoScreen(idKota: kota.idKota, namaKota: kota.namaKota),
                  ));
                },
              )),
              Row(
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        textColor: kPrimaryColor,
                        onPressed: () {
                          // Perform some action
                          print('edit ditekan');
                        },
                        child: const Text('Edit'),
                      ),
                      FlatButton(
                        onPressed: () {
                          // Perform some action
                          print('hapus ditekan');
                        },
                        child: const Text('Hapus'),
                        textColor: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

