import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';

class TaskController extends GetxController {
  // Random syllables
  List<Syllable> createRandomSyllables(List<Syllable> syllables) {
    final Random random = Random();
    final List<Syllable> randomList = List.from(syllables);

    for (int i = 0; i < syllables.length; i++) {
      final int ind = random.nextInt(syllables.length);

      final Syllable value = randomList[ind];
      randomList[ind] = randomList[i];
      randomList[i] = value;
    }
    return randomList;
  }

  // Refresh task
  Word enableSyllables(List<Word> tasks, int index) {
    Word task = new Word(
      name: tasks[index].name,
      imagePath: tasks[index].imagePath,
      syllables: tasks[index].syllables,
      syllablesChoosed: tasks[index].syllables.map<bool>((syllable) {
        return true;
      }).toList(),
    );
    return task;
  }

  // Check if task is correct
  bool checkTask(List<Word> tasks, int index, List<Syllable> syllablesChoosed) {
    bool isCorrect = true;
    tasks[index].syllables.asMap().entries.forEach((entry) {
      if (syllablesChoosed[entry.key].name != entry.value.name) {
        isCorrect = false;
      }
    });
    // if (isCorrect == true) {
    //   Get.dialog(
    //     AlertDialog(
    //       backgroundColor: Colors.lightGreen,
    //       contentTextStyle: TextStyle(
    //         color: Colors.white,
    //       ),
    //       content: Text(
    //         'Você conseguiu, parabéns!',
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   );
    // } else {
    //   Get.dialog(
    //     AlertDialog(
    //       backgroundColor: Colors.red,
    //       contentTextStyle: TextStyle(
    //         color: Colors.white,
    //       ),
    //       content: Text(
    //         'Alguma coisa está errada, tente novamente!',
    //         textAlign: TextAlign.center,
    //       ),
    //     ),
    //   );
    // }

    return isCorrect;
  }
}
