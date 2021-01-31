import 'package:flutter/material.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  // static const String iconUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRzxa9uQ-e0nCX041Zs10GQYPej1-iitMRAdw&usqp=CAU';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                child: Image.asset(
                  'assets/images/logo/pygus-logo.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              Center(
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
