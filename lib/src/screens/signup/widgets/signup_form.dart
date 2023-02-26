import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isLoading = false;

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController repeatPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              'Cadastre-se',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Text('Informe o seu e-mail e senha para cadastrar'),
          ),
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
            padding: EdgeInsets.only(bottom: 12),
            child: TextField(
              obscureText: true,
              controller: repeatPassword,
              decoration: InputDecoration(
                hintText: 'Repita a Senha',
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
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Color.fromRGBO(0, 143, 151, 1.0),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !isLoading
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                    Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              onTap: () async {
                // Loading signup button
                setState(() {
                  isLoading = true;
                });

                String msg = '';

                // Check if e-mail and password was set
                if (email.text == '' && password.text == '') {
                  msg = 'Informe um e-mail e uma senha';
                } else if (email.text == '') {
                  msg = 'Informe um e-mail';
                } else if (password.text == '') {
                  msg = 'Informe uma senha';
                } else if (repeatPassword.text != password.text) {
                  msg = 'As senhas devem ser iguais';
                } else {
                  // Call api to register
                  var apiResponse = await http.post(
                    Uri.parse(
                      'https://pygus-api.herokuapp.com/auth/register',
                      // 'http://192.168.15.9:4200/auth/register',
                    ),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode({
                      'email': email.text,
                      'password': password.text,
                      'isAdmin': false
                    }),
                  );
                  var apiResponseObject = jsonDecode(apiResponse.body);

                  // Check user authentication
                  if (apiResponseObject['code'] == 200) {
                    // Storage token and redirect to /home
                    final storage = new FlutterSecureStorage();
                    await storage.write(
                      key: 'authentication_token',
                      value: apiResponseObject['data']['token'],
                    );
                    Get.offNamed('/home');
                  } else {
                    msg = apiResponseObject['message'];
                  }
                }

                // Show erro message in snackbar
                if (msg != '') {
                  // Close loading signup button
                  setState(() {
                    isLoading = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
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
                  child: Text('Voltar para o '),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Get.offNamed('/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
