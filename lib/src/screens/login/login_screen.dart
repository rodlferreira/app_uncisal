import 'package:flutter/material.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {

  static const String iconUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRzxa9uQ-e0nCX041Zs10GQYPej1-iitMRAdw&usqp=CAU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 6 + MediaQuery.of(context).padding.top,
            ),
            Expanded(
              flex: 6,
              child: Image.network(iconUrl),
            ),
            const SizedBox(
              height: 16,
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
              child: const LoginForm(),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}