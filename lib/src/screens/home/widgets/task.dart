import 'dart:convert';
import 'dart:typed_data';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';
import 'package:prototipo_app_uncisal/src/screens/home/task_controller.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_button.dart';
import 'package:http/http.dart' as http;

class Task extends StatefulWidget {
  final tasks;
  Task({
    this.tasks,
  });
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Word> tasks = List();
  Word task;
  List<Syllable> syllables;
  List<Syllable> syllablesChoosed = [];
  int index = 0;
  bool accepted = false;

  final controller = Get.put(
    TaskController(),
  );

  @override
  void initState() {
    super.initState();

    getTask(index);
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
              child: syllables != null && syllables.length > 0
                  ? Image.memory(
                      task.imagePath,
                      fit: BoxFit.contain,
                      width: 200,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
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
                        SizedBox(
                          height: 50,
                        ),
                        Text('Carregando próxima tarefa...')
                      ],
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
              children: syllables != null && syllables.length > 0
                  ? task.syllables
                      .asMap()
                      .entries
                      .map<Widget>(
                        (entry) => Container(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: DragTarget(
                            builder: (context, list, list2) {
                              return DottedBorder(
                                color: Colors.grey[400],
                                strokeWidth: 1,
                                child: Container(
                                  height: 50,
                                  width: entry.value.name.length > 2 ? 80 : 60,
                                  child: syllablesChoosed != null &&
                                          syllablesChoosed.length > entry.key &&
                                          syllablesChoosed[entry.key] != null
                                      ? Stack(
                                          children: [
                                            SyllableButton(
                                              syllable: entry.value,
                                              enable: true,
                                              isPhoneme: entry.value.isPhoneme,
                                              color: entry.value.isPhoneme
                                                  ? Colors.green
                                                  : Colors.white,
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          children: [
                                            Container(
                                              height: 50,
                                              width: entry.value.name.length > 2
                                                  ? 80
                                                  : 60,
                                              decoration: BoxDecoration(
                                                color: entry.value.isPhoneme
                                                    ? Colors.greenAccent[100]
                                                    : null,
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  entry.value.name,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            entry.value.isPhoneme
                                                ? Glitters(
                                                    interval: Duration(
                                                        milliseconds: 300),
                                                    maxOpacity: 0.7,
                                                    color: Colors.orange,
                                                  )
                                                : Container(),
                                            entry.value.isPhoneme
                                                ? Glitters(
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    outDuration: Duration(
                                                        milliseconds: 500),
                                                    interval: Duration.zero,
                                                    color: Colors.white,
                                                    maxOpacity: 0.5,
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                ),
                              );
                            },
                            onWillAccept: (item) {
                              if (item == entry.value.name &&
                                  entry.key == syllablesChoosed.length) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            onAccept: (item) {
                              // Play audio
                              entry.value.audioPath.play();

                              // Put syllable in list of chooseds syllables
                              List<Syllable> localSyllablesChoosed =
                                  syllablesChoosed != null
                                      ? syllablesChoosed
                                      : [];
                              localSyllablesChoosed.add(entry.value);

                              // Reload state
                              setState(() {
                                syllablesChoosed = localSyllablesChoosed;
                              });

                              // Check if tasks is correct
                              if (localSyllablesChoosed.length ==
                                  syllables.length) {
                                bool isCorrect = controller.checkTask(
                                    task, syllablesChoosed);
                                syllablesChoosed
                                    .forEach((syll) => syll.audioPath.play());

                                Future.delayed(
                                  Duration(
                                    seconds: 3,
                                  ),
                                  () => Get.dialog(
                                    AlertDialog(
                                      backgroundColor: Colors.lightGreen,
                                      contentTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      content: Text(
                                        'Você conseguiu, parabéns!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ).then(
                                    (value) => {
                                      if (isCorrect == true &&
                                          tasks.length != (index + 1))
                                        {
                                          // setState(() {
                                          //   index = index + 1;
                                          //   task = tasks[index];
                                          //   syllables = controller
                                          //       .createRandomSyllables(
                                          //           tasks[index].syllables);
                                          //   syllablesChoosed = [];
                                          // })
                                          getTask(index)
                                        }
                                      else
                                        {Get.offNamed('/success')}
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      )
                      .toList()
                  : [
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                    ],
            ),
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
                                // Play audio
                                entry.value.audioPath.play();
                              },
                              child: syllablesChoosed != null &&
                                      syllablesChoosed.contains(entry.value)
                                  ? Container(
                                      height: 50,
                                    )
                                  : Draggable(
                                      child: SyllableButton(
                                        syllable: entry.value,
                                        color: Colors.white,
                                      ),
                                      feedback: Material(
                                        child: SyllableButton(
                                          syllable: entry.value,
                                          color: Colors.white,
                                        ),
                                      ),
                                      childWhenDragging: Container(),
                                      data: entry.value.name,
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
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    // Refresh task
                    task = controller.enableSyllables(task);
                    syllables =
                        controller.createRandomSyllables(task.syllables);
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

  // Get one task from API
  void getTask(int localIndex) async {
    setState(() {
      syllables = [];
      syllablesChoosed = [];
    });

    final storage = new FlutterSecureStorage();
    String id = widget.tasks[localIndex]['_id'];

    var apiResponse = await http.get(
      'https://pygus-api.herokuapp.com/tasks/$id',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token': await storage.read(key: 'authentication_token'),
      },
    );
    var apiResponseObject = jsonDecode(apiResponse.body);
    var el;

    if (apiResponseObject['code'] != 400) {
      el = apiResponseObject['data'];
      // Create Image String
      List<int> imageBuffer = [];
      el['image']['data']['data'].forEach((data) {
        imageBuffer.add(data);
      });
      String imgString = base64Encode(imageBuffer);
      Uint8List imgDecoded = base64Decode(imgString);
      Word localTask = Word(
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
            name: entry.value['syllable'].toUpperCase(),
            audioPath: audioPath,
            isPhoneme: entry.value['isPhoneme'],
          );
        }).toList(),
        syllablesChoosed: el['syllables'].map<bool>((syllable) {
          return true;
        }).toList(),
      );

      setState(() {
        task = localTask;
        index = index + 1;
        syllables = controller.createRandomSyllables(localTask.syllables);
      });
    }
  }
}
