import 'dart:math';

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
  Word enableSyllables(Word task) {
    Word localTask = new Word(
      name: task.name,
      imagePath: task.imagePath,
      syllables: task.syllables,
      syllablesChoosed: task.syllables.map<bool>((syllable) {
        return true;
      }).toList(),
    );
    return localTask;
  }

  // Check if task is correct
  bool checkTask(Word task, List<Syllable> syllablesChoosed) {
    bool isCorrect = true;
    task.syllables.asMap().entries.forEach((entry) {
      if (syllablesChoosed[entry.key].name != entry.value.name) {
        isCorrect = false;
      }
    });

    return isCorrect;
  }
}
