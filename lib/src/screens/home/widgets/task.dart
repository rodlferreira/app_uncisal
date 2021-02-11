import 'dart:convert';
import 'dart:typed_data';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';
import 'package:prototipo_app_uncisal/src/screens/home/task_controller.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_button.dart';
import 'package:http/http.dart' as http;

class Task extends StatefulWidget {
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Word> tasks = List();
  Word task;
  List<Syllable> syllables;
  List<Syllable> syllablesChoosed;
  int index;

  final controller = Get.put(
    TaskController(),
  );

  @override
  void initState() {
    super.initState();

    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 200,
            child: Center(
              child: index != null
                  ? Image.memory(
                      tasks[index].imagePath,
                      fit: BoxFit.contain,
                      width: 200,
                    )
                  : SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(
                            0,
                            143,
                            151,
                            1,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: 25,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    syllablesChoosed != null && syllablesChoosed.length > 0
                        ? syllablesChoosed
                            .asMap()
                            .entries
                            .map<Widget>(
                              (entry) => Container(
                                padding: EdgeInsets.only(
                                  right: 2,
                                ),
                                child: SyllableButton(
                                  syllable: entry.value,
                                  enable: true,
                                ),
                              ),
                            )
                            .toList()
                        : [
                            SizedBox(
                              width: 10,
                              height: 40,
                            ),
                          ]),
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: syllables != null
                  ? syllables
                      .asMap()
                      .entries
                      .map<Widget>(
                        (entry) => Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (task.syllablesChoosed[entry.key] == true &&
                                    task.syllables[syllablesChoosed != null
                                            ? syllablesChoosed.length
                                            : 0] ==
                                        entry.value) {
                                  // Put syllable in list of chooseds syllables
                                  List<Syllable> localSyllablesChoosed =
                                      syllablesChoosed != null
                                          ? syllablesChoosed
                                          : [];
                                  localSyllablesChoosed.add(entry.value);

                                  // Play audio
                                  entry.value.audioPath.play();

                                  // Reload state
                                  setState(() {
                                    task.syllablesChoosed[entry.key] = false;
                                    syllablesChoosed = localSyllablesChoosed;
                                  });

                                  // Check if tasks is correct
                                  if (localSyllablesChoosed.length ==
                                      syllables.length) {
                                    bool isCorrect = controller.checkTask(
                                        tasks, index, syllablesChoosed);
                                    Future.delayed(
                                      Duration(
                                        seconds: 1,
                                      ),
                                      () => Get.dialog(
                                        AlertDialog(
                                          backgroundColor: isCorrect == true
                                              ? Colors.lightGreen
                                              : Colors.red,
                                          contentTextStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          content: Text(
                                            isCorrect == true
                                                ? 'Você conseguiu, parabéns!'
                                                : 'Alguma coisa está errada, tente novamente!',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ).then(
                                        (value) => {
                                          if (isCorrect == true)
                                            {
                                              setState(() {
                                                index = index + 1;
                                                task = tasks[index];
                                                syllables = controller
                                                    .createRandomSyllables(
                                                        tasks[index].syllables);
                                                syllablesChoosed = [];
                                              })
                                            }
                                          else
                                            {
                                              setState(() {
                                                // Refresh task
                                                task =
                                                    controller.enableSyllables(
                                                        tasks, index);
                                                syllables = controller
                                                    .createRandomSyllables(
                                                        tasks[index].syllables);
                                                syllablesChoosed = [];
                                              })
                                            }
                                        },
                                      ),
                                    );
                                  }
                                }
                              },
                              child: SyllableButton(
                                syllable: entry.value,
                                enable: task.syllablesChoosed[entry.key],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      )
                      .toList()
                  : [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(30),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    // Refresh task
                    task = controller.enableSyllables(tasks, index);
                    syllables = controller
                        .createRandomSyllables(tasks[index].syllables);
                    syllablesChoosed = [];
                  });
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
                child: Text('Refazer tarefa'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Get all tasks from API
  void getTasks() async {
    List<Word> localTasks = [];

    final storage = new FlutterSecureStorage();
    var apiResponse = await http.get(
      'https://pygus-api.herokuapp.com/tasks',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': await storage.read(key: 'authentication_token'),
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);
    apiResponseObject['data'].forEach((el) {
      // Create Image String
      List<int> imageBuffer = [];
      el['image']['data']['data'].forEach((data) {
        imageBuffer.add(data);
      });
      String imgString = base64Encode(imageBuffer);
      Uint8List imgDecoded = base64Decode(imgString);

      localTasks.add(
        Word(
          name: el['name'],
          imagePath: imgDecoded,
          syllables: el['syllables'].asMap().entries.map<Syllable>((entry) {
            // Create Image String
            Uint8List soundBuffer = base64Decode(
              el['audios'][entry.key]['data'],
            );
            Audio audioPath = Audio.loadFromByteData(
              ByteData.sublistView(
                soundBuffer,
              ),
            );
            return Syllable(
              name: entry.value.toUpperCase(),
              audioPath: audioPath,
            );
          }).toList(),
          syllablesChoosed: el['syllables'].map<bool>((syllable) {
            return true;
          }).toList(),
        ),
      );
    });

    setState(() {
      tasks = localTasks;
      task = localTasks[0];
      index = 0;
      syllables = controller.createRandomSyllables(tasks[0].syllables);
    });
  }
}
