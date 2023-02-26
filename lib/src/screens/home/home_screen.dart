import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/task.dart';
import 'package:prototipo_app_uncisal/src/screens/tasks_list/tasks_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final task;
  final tasks;
  final nextIndex;
  HomeScreen({
    this.task,
    this.tasks,
    this.nextIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 143, 151, 1),
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
                      InkWell(
                        onTap: () async {
                          await DefaultCacheManager().emptyCache();
                          Get.off(
                            () => TasksListScreen(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color.fromRGBO(222, 184, 33, 1),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Voltar para o fonemas',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: null,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color.fromRGBO(222, 184, 33, 1),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Text(
                            task.phoneme,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Task(
            task: this.task,
            tasks: this.tasks,
            nextIndex: this.nextIndex,
          ),
        ],
      ),
    );
  }
}
