import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';

class TaskController extends GetxController {
  // Refresh task
  Word enableSyllables(Word task) {
    Word localTask = new Word(
      name: task.name,
      imagePath: task.imagePath,
      syllables: task.syllables,
      syllablesChoosed: task.syllables.map<bool>((syllable) {
        return true;
      }).toList(),
      wordAudio: task.wordAudio,
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
