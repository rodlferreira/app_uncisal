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
    final storage = new FlutterSecureStorage();
    var accessToken = await storage.read(key: 'authentication_token');
    var apiResponse = await http.get(
      Uri.parse(
        'https://pygus-api.herokuapp.com/tasks',
        // 'http://192.168.15.9:4200/tasks',
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': accessToken,
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);
    return apiResponseObject['data'];
  }
}
