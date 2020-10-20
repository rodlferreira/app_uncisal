import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Pygus',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 38,),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}