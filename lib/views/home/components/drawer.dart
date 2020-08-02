import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Home"),
          trailing: Icon(Icons.home),
          onTap: (){
            Navigator.pushNamed(context, '/Home');
          },
        ),
        ListTile(
          title: Text("Data Orderan"),
          trailing: Icon(Icons.shopping_basket),
          onTap: (){
            Navigator.pushNamed(context, '/Order');
          },
        ),
        ListTile(
          title: Text("Data Perjalanan"),
          trailing: Icon(Icons.flight),
          onTap: (){
            Navigator.pushNamed(context, '/Trip');
          },
        ),
        ListTile(
          title: Text("Quest and Answer"),
          trailing: Icon(Icons.question_answer),
          onTap: (){
            Navigator.pushNamed(context, '/QA');
          },
        ),
      ],
    );
  }
}
