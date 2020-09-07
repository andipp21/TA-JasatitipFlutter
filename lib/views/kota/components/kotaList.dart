import 'package:app_ta/controllers/kotaController.dart';
import 'package:app_ta/models/kotaModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/kota/crudScreens/editKotaScreen.dart';
import 'package:app_ta/views/toko/toko.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      itemBuilder: (context, i) {
        return KotaTile(kota: kota[i]);
      },
    );
  }
}

class KotaTile extends StatelessWidget {
  final KotaModel kota;
  KotaTile({this.kota});

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () async {
        await Fluttertoast.showToast(
            msg: "Membatalkan Menghapus Kota ${kota.namaKota}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        await Navigator.pop(context);
      },
    );

    Widget continueButton = FlatButton(
      child: Text("Iya"),
      onPressed: () async {
        await KotaController().removeData(kota.idKota).then((value) =>
            Fluttertoast.showToast(
                msg: "Berhasil Menghapus Kota ${kota.namaKota}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: kPrimaryColor,
                textColor: Colors.white,
                fontSize: 16.0));
        await Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Kamu Yakin?"),
      content: Text(
          "Data kota ${kota.namaKota} akan terhapus"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Card(
        elevation: 4,
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                child: Text(
                  kota.namaKota,
                  style: TextStyle(fontSize: 16, color: kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new TokoScreen(
                        idKota: kota.idKota, namaKota: kota.namaKota),
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
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) => new EditKotaForm(
                                    kota: kota,
                                  )));
                        },
                        child: const Text('Edit'),
                      ),
                      FlatButton(
                        onPressed: () {
                          showAlertDialog(context);
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
