import 'package:flutter/material.dart';

import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
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
              Center(
                child: SignupForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
