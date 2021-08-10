import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/tasks_list/tasks_list_screen.dart';

class SuccessLevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(0, 143, 151, 1),
        body: Container(
          padding: EdgeInsets.all(
            20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/success.png',
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'PARABÉNS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Você concluiu esse fonema.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () async {
                  await DefaultCacheManager().emptyCache();
                  Get.to(
                    () => TasksListScreen(),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                color: Color.fromRGBO(222, 184, 33, 1),
                textColor: Colors.white,
                padding: EdgeInsets.all(12),
                child: Text('Escolher outro fonema'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
