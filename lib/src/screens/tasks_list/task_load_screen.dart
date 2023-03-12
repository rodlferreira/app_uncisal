import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';
import 'package:prototipo_app_uncisal/src/screens/home/home_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/success_level/success_level_screen.dart';
import 'package:prototipo_app_uncisal/src/shared/widgets/loading_screen.dart';

import 'package:http/http.dart' as http;

class TaskLoadScreen extends StatefulWidget {
  final tasks;
  final index;
  TaskLoadScreen({
    this.tasks,
    this.index,
  });

  @override
  _TaskLoadScreenState createState() => _TaskLoadScreenState();
}

class _TaskLoadScreenState extends State<TaskLoadScreen> {
  @override
  void initState() {
    super.initState();

    getTask();
  }

  void getTask() async {
    if (widget.index != null) {
      var task = await getOneTask();

      Get.off(
        () => HomeScreen(
            task: task,
            tasks: widget.tasks,
            nextIndex: (widget.index + 1) == widget.tasks.length
                ? null
                : (widget.index + 1)),
      );
    } else {
      Future.delayed(
        Duration(
          seconds: 1,
        ),
        () => Get.off(
          () => SuccessLevelScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      imagePath: 'assets/images/task_one_loading.png',
      title: 'Carregando a tarefa',
      subtitle: 'Aguarde...',
    );
  }

  // Get one task from API
  Future<Word> getOneTask() async {
    final storage = new FlutterSecureStorage();
    String id = widget.tasks[widget.index]['_id'];

    var apiResponse = await http.get(
      Uri.parse(
        // 'https://pygus-api.herokuapp.com/tasks/$id',
        'http://191.101.18.67:3000/tasks/$id',
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': await storage.read(key: 'authentication_token'),
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);

    if (apiResponseObject['code'] != 400) {
      return Word.fromJson(apiResponseObject['data']);
    } else
      return null;
  }
}
