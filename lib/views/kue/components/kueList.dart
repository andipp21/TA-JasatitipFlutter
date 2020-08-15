import 'package:app_ta/controllers/kueController.dart';
import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/style.dart';
import 'package:app_ta/views/kue/crudScreens/editKueScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class KueList extends StatefulWidget {
  final idToko;
  KueList({this.idToko});
  @override
  _KueListState createState() => _KueListState(idToko: idToko);
}

class _KueListState extends State<KueList> {
  final idToko;
  _KueListState({this.idToko});

  @override
  Widget build(BuildContext context) {
    final kue = Provider.of<List<KueModel>>(context);
    var dataKue = [];
    kue.forEach((kue) {
      if(kue.idToko == idToko){
        dataKue.add(kue);
      }
    });

    print(dataKue);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dataKue.length,
      // ignore: missing_return
      itemBuilder: (context, i){
        return KueCard(kue: dataKue[i]);
      },
    );
  }
}

class KueCard extends StatelessWidget {

  final KueModel kue;
  KueCard({this.kue});

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () async {
        await Fluttertoast.showToast(
            msg: "Membatalkan Menghapus Kue ${kue.namaKue}",
            toastLength: Toast.LENGTH_SHORT,
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
        await KueController().removeData(kue.idKue).then((value) =>
            Fluttertoast.showToast(
                msg: "Berhasil Menghapus Kue ${kue.namaKue}",
                toastLength: Toast.LENGTH_SHORT,
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
          "Data kue ${kue.namaKue} akan terhapus"),
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
      padding: EdgeInsets.only(top: 8),
      child: Card(
        elevation: 16,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {

          },
          child: ListTile(
            leading: Image.network(kue.gambarKue, fit: BoxFit.fill),
            title: Text(
              kue.namaKue,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: <Widget>[
                Text('Rp. ${kue.hargaKue.toString()}'),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      textColor: kPrimaryColor,
                      onPressed: () {
                        // Perform some action
                        Navigator.of(context).push(
                            new MaterialPageRoute(builder: (context) => new FormEditKue(kue: kue,))
                        );
                      },
                      child: const Text('Edit', style: TextStyle(fontSize: 16),),
                    ),
                    FlatButton(
                      onPressed: () {
                        // Perform some action
                        KueController().removeData(kue.idKue).then((value) =>
                            Fluttertoast.showToast(
                                msg: "Berhasil Menghapus Kue",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kPrimaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0
                            )
                        );
                      },
                      child: const Text('Hapus', style: TextStyle(fontSize: 16),),
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
