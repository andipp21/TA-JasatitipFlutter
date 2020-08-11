import 'package:app_ta/controllers/signinController.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlutterLogo(size: 100),
              SizedBox(height: 50),
              OutlineButton(
                onPressed: (){
                  signInWithGoogle().whenComplete(() {
                    Navigator.of(context).pushNamed('/Home');
                  });
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text('Sign In dengan Google'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
