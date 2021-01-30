import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Image.asset(
              'assets/images/logo/pygus-logo.png',
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
