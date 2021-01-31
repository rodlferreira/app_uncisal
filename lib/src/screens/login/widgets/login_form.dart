import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatelessWidget {
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
              onPressed: () async {
                String msg = '';

                // Check if e-mail and password was set
                if (email.text == '' && password.text == '') {
                  msg = 'Informe um e-mail e uma senha';
                } else if (email.text == '') {
                  msg = 'Informe um e-mail';
                } else if (password.text == '') {
                  msg = 'Informe uma senha';
                } else {
                  // Call api to login
                  var apiResponse = await http.post(
                    'https://pygus-api.herokuapp.com/auth/login',
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode({
                      'email': email.text,
                      'password': password.text,
                    }),
                  );
                  var apiResponseObject = jsonDecode(apiResponse.body);

                  // Check user authentication
                  if (apiResponseObject['code'] == 200) {
                    // ToDo: storage token and redirect to /home
                    print(apiResponseObject['data']['token']);
                    // Get.offNamed('/home');
                  } else {
                    msg = apiResponseObject['message'];
                  }
                }

                // Show erro message in snackbar
                if (msg != '') {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('Não tem conta? '),
                ),
                Container(
                  child: Text('Registre-se'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
