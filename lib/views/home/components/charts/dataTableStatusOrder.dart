import 'package:app_ta/models/orderModel.dart';
import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusOrderBulanIni extends StatefulWidget {
  @override
  _StatusOrderBulanIniState createState() => _StatusOrderBulanIniState();
}

class _StatusOrderBulanIniState extends State<StatusOrderBulanIni> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<OrderModel>>(context);
    int s1 = 0;
    int s2 = 0;
    int s3 = 0;

    String status1 = "Order Sedang di Konfirmasi";
    String status2 = "Order Akan di Belikan";
    String status3 = "Order Dapat di Ambil";


    var bulanIni = DateTime.now().month;

    order.forEach((order) {
      var bulanPesan = order.tanggalPesan.toDate().month;
      if(bulanIni == bulanPesan){
        if(order.statusOrder == status1){
          s1++;
        } else if (order.statusOrder == status2){
          s2++;
        } else if (order.statusOrder == status3){
          s3++;
        }
      }
    });

    return Column(
      children: <Widget>[
        Text(
          'Data Orderan berdasarkan statusnya',
          style: TextStyle(color: kPrimaryColor),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FittedBox(
            child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      status1,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      status2,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      status3,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                      cells: <DataCell>[
                        DataCell(Text(s1.toString(), textAlign: TextAlign.center,)),
                        DataCell(Text(s2.toString())),
                        DataCell(Text(s3.toString())),
                      ]
                  )
                ]
            ),
          ),
        ),
      ],
    );
  }
}
