import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototipo_app_uncisal/src/screens/home/home_screen.dart';

class LevelChoose extends StatefulWidget {
  @override
  _LevelChooseState createState() => _LevelChooseState();
}

class _LevelChooseState extends State<LevelChoose> {
  bool isLoading = false;
  var tasks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(
          0,
          143,
          151,
          1,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 80,
                  bottom: 5,
                ),
                child: Text(
                  'Bem vindo,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: Text(
                  'Escolha abaixo um nível para começar a jogar.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () async {
                    // Get.offNamed('/task');
                    await getTasks();
                    Get.to(
                      () => HomeScreen(
                        tasks: tasks,
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Color.fromRGBO(
                    222,
                    184,
                    33,
                    1,
                  ),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Text('Nível 1'),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Color.fromRGBO(
                    222,
                    184,
                    33,
                    1,
                  ),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Text('Nível 2'),
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Color.fromRGBO(
                    222,
                    184,
                    33,
                    1,
                  ),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(12),
                  child: Text('Nível 3'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: !isLoading
                      ? Text('Sair')
                      : SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          ),
                        ),
                  onPressed: () async {
                    // Loading button
                    setState(() {
                      isLoading = true;
                    });

                    // Logout
                    final storage = new FlutterSecureStorage();
                    await storage.delete(
                      key: 'authentication_token',
                    );
                    Get.offNamed('/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Get all tasks from API
  Future<void> getTasks() async {
    final storage = new FlutterSecureStorage();
    var access_token = await storage.read(key: 'authentication_token');
    var apiResponse = await http.get(
      'https://pygus-api.herokuapp.com/tasks',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': access_token,
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);
    tasks = apiResponseObject['data'];
  }
}
