import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  // const LoginForm();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 6),
            child: TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-mail',
                filled: true,
                fillColor: Color(0xffececec),
                contentPadding: EdgeInsets.fromLTRB(14, 3, 8, 3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 12),
            child: TextField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                hintText: 'Senha',
                filled: true,
                fillColor: Color(0xffececec),
                contentPadding: EdgeInsets.fromLTRB(14, 3, 8, 3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              color: Color.fromRGBO(0, 143, 151, 1.0),
              textColor: Colors.white,
              padding: EdgeInsets.all(12),
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Get.offNamed('/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}
