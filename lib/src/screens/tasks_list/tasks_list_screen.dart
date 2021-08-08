import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/phoneme_task_choose/phoneme_task_choose.dart';
import 'package:prototipo_app_uncisal/src/shared/widgets/loading_screen.dart';

import 'package:http/http.dart' as http;

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
    var tasks = await getAllTasks();

    // Get all phonemes
    var phonemes = tasks.map((el) {
      return el['phoneme'];
    });

    // Remove duplicated phonemes
    phonemes = phonemes.toSet().toList();

    // Create list of all tasks by phoneme
    List tasksByPhoneme = [];
    phonemes.forEach((phoneme) {
      List localTasks = [];

      tasks.forEach((task) {
        if (task['phoneme'] == phoneme) {
          localTasks.add(task);
        }
      });

      var elementToAdd = {
        'phoneme': phoneme,
        'tasks': localTasks,
      };

      tasksByPhoneme.add(elementToAdd);
    });

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
    final storage = new FlutterSecureStorage();
    var access_token = await storage.read(key: 'authentication_token');
    var apiResponse = await http.get(
      'https://pygus-api.herokuapp.com/tasks',
      // 'http://192.168.15.9:4200/tasks',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': access_token,
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);
    return apiResponseObject['data'];
  }
}
