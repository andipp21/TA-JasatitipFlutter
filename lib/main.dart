import 'package:app_ta/style.dart';
import 'package:app_ta/views/home/home.dart';
import 'package:app_ta/views/kota/kota.dart';
import 'package:app_ta/views/login.dart';
import 'package:app_ta/views/order/order.dart';
import 'package:app_ta/views/qa/qa.dart';
import 'package:app_ta/views/trip/trip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Jasa Titip',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/Login' : (context) => new Login(),
        '/Home' : (context) => new HomeScreens(),
        '/Order' : (context) => new OrderScreen(),
        '/Kota' : (context) => new KotaScreen(),
        '/Trip' : (context) => new TripScreen(),
        '/QA' : (context) => new QAScreen(),
      },
    );
  }
}