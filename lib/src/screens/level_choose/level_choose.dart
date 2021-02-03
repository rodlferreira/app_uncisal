import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LevelChoose extends StatefulWidget {
  @override
  _LevelChooseState createState() => _LevelChooseState();
}

class _LevelChooseState extends State<LevelChoose> {
  bool isLoading = false;

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
                  onPressed: () {},
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
}
