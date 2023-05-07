import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:glitters/glitters.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_button.dart';
import 'package:prototipo_app_uncisal/src/screens/tasks_list/task_load_screen.dart';
import 'package:prototipo_app_uncisal/src/services/api.dart';

class Task extends StatefulWidget {
  final Word task;
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
  List<String> syllablesChoosed = [];
  bool accepted = false;

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
            height: MediaQuery.of(context).size.height - 290,
            // height: 200,
            child: Center(
              child: Image.network(
                ApiService.getTaskImage(widget.task.name),
                fit: BoxFit.contain,
                // width: 200,
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
                                          syllable: entry.value.name,
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
                          if (item == entry.value.id &&
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
                          }

                          // Put syllable in list of chooseds syllables
                          List<String> localSyllablesChoosed =
                              syllablesChoosed != null ? syllablesChoosed : [];
                          localSyllablesChoosed.add(entry.value.id);

                          // Reload state
                          setState(() {
                            syllablesChoosed = localSyllablesChoosed;
                          });

                          // Check if tasks is correct
                          if (localSyllablesChoosed.length ==
                              widget.task.syllablesSorted.length) {
                            for (var i = 0;
                                i < widget.task.syllables.length;
                                i++) {
                              widget.task.syllables[i].audioPath.dispose();
                            }
                            await Future.delayed(
                                Duration(
                                  milliseconds: 1500,
                                ), () {
                              widget.task.wordAudio.play();
                              widget.task.wordAudio.dispose();
                            });

                            Future.delayed(
                              Duration(
                                milliseconds: 2000,
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
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.task.syllablesRandom
                  .asMap()
                  .entries
                  .map<Widget>((entry) {
                var syllableRandom = widget.task.syllables.firstWhere(
                    (element) => element.id == entry.value, orElse: () {
                  return null;
                });

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Play audio
                        syllableRandom.audioPath.play();
                      },
                      child: syllablesChoosed != null &&
                              syllablesChoosed.contains(syllableRandom.id)
                          ? Container(
                              height: 50,
                            )
                          : Draggable(
                              child: SyllableButton(
                                syllable: syllableRandom.name,
                                color: Colors.white,
                              ),
                              feedback: Material(
                                child: SyllableButton(
                                  syllable: syllableRandom.name,
                                  color: Colors.white,
                                ),
                              ),
                              childWhenDragging: Container(),
                              data: syllableRandom.id,
                            ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 5),
              width: double.infinity,
              child: InkWell(
                onTap: accepted == false
                    ? null
                    : () async {
                        await DefaultCacheManager().emptyCache();
                        Get.off(
                          () => TaskLoadScreen(
                            tasks: widget.tasks,
                            index: widget.nextIndex,
                          ),
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
                    'Avançar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
