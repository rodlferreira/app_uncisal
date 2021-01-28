import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromRGBO(255, 214, 51, 1.0),
                      Color.fromRGBO(255, 238, 169, 1.0)
                    ])),
                child: Center(
                    child: Image.asset('assets/images/logo/pygus-logo.png',
                        height: 200, fit: BoxFit.fill)))));
  }
}
