import 'package:audioplayers/audio_cache.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/screens/home/task_controller.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_button.dart';
import 'package:prototipo_app_uncisal/src/screens/tasks_list/task_load_screen.dart';

class Task extends StatefulWidget {
  final task;
  final tasks;
  final nextIndex;
  Task({
    this.task,
    this.tasks,
    this.nextIndex,
  });
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  List<Syllable> syllables;
  List<Syllable> syllablesChoosed = [];
  bool accepted = false;
  final AudioCache audioCache = AudioCache();

  final controller = Get.put(
    TaskController(),
  );

  void initState() {
    super.initState();
    syllables = controller.createRandomSyllables(widget.task.syllables);
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
              child: Image.network(
                widget.task.imagePath,
                fit: BoxFit.contain,
                width: 200,
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
              children: widget.task.syllables
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
                                                interval:
                                                    Duration(milliseconds: 300),
                                                maxOpacity: 0.7,
                                                color: Colors.orange,
                                              )
                                            : Container(),
                                        entry.value.isPhoneme
                                            ? Glitters(
                                                duration:
                                                    Duration(milliseconds: 200),
                                                outDuration:
                                                    Duration(milliseconds: 500),
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
                        onAccept: (item) async {
                          // Play audio
                          if (entry.value.audioPath != null) {
                            entry.value.audioPath.play();
                            entry.value.audioPath.dispose();
                          }

                          // Put syllable in list of chooseds syllables
                          List<Syllable> localSyllablesChoosed =
                              syllablesChoosed != null ? syllablesChoosed : [];
                          localSyllablesChoosed.add(entry.value);

                          // Reload state
                          setState(() {
                            syllablesChoosed = localSyllablesChoosed;
                          });

                          // Check if tasks is correct
                          if (localSyllablesChoosed.length ==
                              syllables.length) {
                            await Future.delayed(
                                Duration(
                                  milliseconds: 1500,
                                ), () {
                              widget.task.wordAudio.play();
                              widget.task.wordAudio.dispose();
                            });

                            Future.delayed(
                              Duration(
                                seconds: widget.task.wordAudioSegs,
                              ),
                              () => setState(
                                () {
                                  accepted = true;
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: syllables
                  .asMap()
                  .entries
                  .map<Widget>(
                    (entry) => Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Play audio
                            entry.value.audioPath.play();
                            entry.value.audioPath.dispose();
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
                  .toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              width: double.infinity,
              child: RaisedButton(
                onPressed: accepted == false
                    ? null
                    : () {
                        Get.to(
                          () => TaskLoadScreen(
                            tasks: widget.tasks,
                            index: widget.nextIndex,
                          ),
                        );
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
                child: Text('Avançar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
