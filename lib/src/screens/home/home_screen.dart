import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/task.dart';

class HomeScreen extends StatelessWidget {
  final tasks;
  HomeScreen({
    this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
        0,
        143,
        151,
        1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            Get.offNamed('/home');
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
                          child: Text('Voltar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Task(
            tasks: tasks,
          ),
        ],
      ),
    );
  }
}
