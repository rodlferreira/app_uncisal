import 'dart:convert';
import 'dart:typed_data';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
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

      Get.to(
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
        () => Get.to(
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
      'https://pygus-api.herokuapp.com/tasks/$id',
      // 'http://192.168.15.9:4200/tasks/$id',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': await storage.read(key: 'authentication_token'),
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);
    var el;

    if (apiResponseObject['code'] != 400) {
      el = apiResponseObject['data'];

      List<int> audiosSegs = [];
      int wordAudiosSegs = 0;

      // Create Word Audio
      List<int> wordSoundBuffer =
          el['completeWordAudio']['data']['data'].cast<int>();
      String wordSoundString = base64Encode(wordSoundBuffer);
      Uint8List wordSoundFromStringBuffer = base64Decode(wordSoundString);
      Audio wordAudioPath = Audio.loadFromByteData(
        ByteData.sublistView(
          wordSoundFromStringBuffer,
        ),
        onDuration: (seg) => wordAudiosSegs = seg.toInt(),
      );

      Word localTask = Word(
        name: el['name'],
        imagePath: widget.tasks[widget.index]['image'],
        audioPath: el['syllables'].asMap().entries.map<Audio>((entry) {
          if (entry.key == el['audios'].length) return null;
          // Create Image String
          Uint8List soundBuffer = base64Decode(
            el['audios'][entry.key]['data'],
          );
          Audio audioPath = Audio.loadFromByteData(
            ByteData.sublistView(
              soundBuffer,
            ),
            onDuration: (seg) => audiosSegs.add(seg.toInt()),
          );
          return audioPath;
        }).toList(),
        syllables: el['syllables'].asMap().entries.map<Syllable>((entry) {
          Audio audioPath;
          if (entry.key < el['audios'].length) {
            // Create Image String
            Uint8List soundBuffer = base64Decode(
              el['audios'][entry.key]['data'],
            );
            audioPath = Audio.loadFromByteData(
              ByteData.sublistView(
                soundBuffer,
              ),
            );
          }
          return Syllable(
            name: entry.value['syllable'].toUpperCase(),
            audioPath: audioPath,
            isPhoneme: entry.value['isPhoneme'],
          );
        }).toList(),
        syllablesChoosed: el['syllables'].map<bool>((syllable) {
          return true;
        }).toList(),
        wordAudio: wordAudioPath,
        wordAudioSegs: wordAudiosSegs,
      );

      localTask.audiosSegs = audiosSegs;

      return localTask;
    } else
      return null;
  }
}
