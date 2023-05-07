import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/phoneme_task_choose/phoneme_task_choose.dart';
import 'package:prototipo_app_uncisal/src/services/api.dart';
import 'package:prototipo_app_uncisal/src/shared/widgets/loading_screen.dart';

class TasksListScreen extends StatefulWidget {
  @override
  _TasksListScreenState createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  @override
  void initState() {
    super.initState();

    getTasks();
  }

  void getTasks() async {
    var tasksByPhoneme = await getAllTasks();

    Get.to(
      () => PhonemeTaskChoose(
        tasksByPhoneme: tasksByPhoneme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      imagePath: 'assets/images/task_loading.png',
      title: 'Carregando os fonemas',
      subtitle: 'Aguarde...',
    );
  }

  // Get all tasks from API
  Future<List> getAllTasks() async {
    var response = await ApiService.getAllTasks();
    return response;
  }
}
