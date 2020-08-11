import 'package:app_ta/style.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Home", style: TextStyle(color: kPrimaryColor),),
            trailing: Icon(Icons.home, color: kPrimaryColor),
            onTap: (){
              Navigator.pushNamed(context, '/Home');
            },
          ),
          ListTile(
            title: Text("Kota", style: TextStyle(color: kPrimaryColor),),
            trailing: Icon(Icons.store, color: kPrimaryColor),
            onTap: (){
              Navigator.pushNamed(context, '/Kota');
            },
          ),
          ListTile(
            title: Text("Data Orderan", style: TextStyle(color: kPrimaryColor)),
            trailing: Icon(Icons.shopping_basket, color: kPrimaryColor),
            onTap: (){
              Navigator.pushNamed(context, '/Order');
            },
          ),
          ListTile(
            title: Text("Data Perjalanan", style: TextStyle(color: kPrimaryColor)),
            trailing: Icon(Icons.flight, color: kPrimaryColor),
            onTap: (){
              Navigator.pushNamed(context, '/Trip');
            },
          ),
          ListTile(
            title: Text("Quest and Answer", style: TextStyle(color: kPrimaryColor)),
            trailing: Icon(Icons.question_answer, color: kPrimaryColor),
            onTap: (){
              Navigator.pushNamed(context, '/QA');
            },
          ),
        ],
      ),
    );
  }
}
