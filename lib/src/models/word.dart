import 'dart:math';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/services/api.dart';

class Word {
  final String name;
  final String imagePath;
  final List<Syllable> syllables;
  final List<String> syllablesSorted;
  final List<String> syllablesRandom;
  final List<bool> syllablesChoosed;
  final Audio wordAudio;
  String phoneme;

  Word({
    this.name,
    this.imagePath,
    this.syllables,
    this.syllablesSorted,
    this.syllablesRandom,
    this.syllablesChoosed,
    this.wordAudio,
    this.phoneme,
  });
// convert Json to a Model
  factory Word.fromJson(Map<String, dynamic> json) {
    // Create Word Audio
    Audio wordAudio =
        Audio.loadFromRemoteUrl(ApiService.getTaskAudio(json['name']));

    // Random syllables
    Random random = Random();
    var syllablesFromJsonToRandom =
        json['syllables'].map((el) => el['_id']).toList();
    List<String> randomList = List.from(syllablesFromJsonToRandom);
    for (int i = 0; i < json['syllables'].length; i++) {
      int ind = random.nextInt(json['syllables'].length);
      String value = randomList[ind];
      randomList[ind] = randomList[i];
      randomList[i] = value;
    }

    // Sort syllables
    List<String> syllablesFromJsonToSort =
        List.from(json['syllables'].map((el) => el['syllable']).toList());

    return Word(
      name: json['name'] as String,
      imagePath: json['image'] as String,
      phoneme: json['phoneme'] as String,
      syllables: json['syllables'].asMap().entries.map<Syllable>((entry) {
        Audio audioPath = Audio.loadFromRemoteUrl(ApiService.getSyllableAudio(
            json['name'], json['syllables'][entry.key]['syllable']));

        return Syllable(
          id: entry.value['_id'],
          name: entry.value['syllable'].toUpperCase(),
          audioPath: audioPath,
          isPhoneme: entry.value['isPhoneme'],
        );
      }).toList(),
      syllablesSorted: syllablesFromJsonToSort,
      syllablesRandom: randomList,
      syllablesChoosed: json['syllables'].map<bool>((syllable) {
        return true;
      }).toList(),
      wordAudio: wordAudio,
    );
  }
}
