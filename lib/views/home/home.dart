import 'package:app_ta/style.dart';
import 'package:app_ta/views/home/components/body.dart';
import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }

  AppBar appHeader(){
    return AppBar(
      elevation: 0,
      title: Text('Aplikasi Jasa Titip'),
      centerTitle: true,
    );
  }
        
}

