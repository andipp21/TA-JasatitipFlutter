import 'package:app_ta/models/kueModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
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

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: kue.length,
      itemBuilder: (context, i){
        if(kue[i].idToko == idToko){
          return KueCard(kue: kue[i]);
        }
      },
    );
  }
}

class KueCard extends StatelessWidget {

  final KueModel kue;
  KueCard({this.kue});

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
