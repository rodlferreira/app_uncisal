import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

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
    List<int> wordSoundBuffer =
        json['completeWordAudio']['data']['data'].cast<int>();
    String wordSoundString = base64Encode(wordSoundBuffer);
    Uint8List wordSoundFromStringBuffer = base64Decode(wordSoundString);
    Audio wordAudio = Audio.loadFromByteData(
      ByteData.sublistView(
        wordSoundFromStringBuffer,
      ),
      // onDuration: (seg) => wordAudiosSegs = seg.toInt(),
    );

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
        if (entry.key == json['audios'].length) return null;
        // Create Audio
        Uint8List soundBuffer = base64Decode(
          json['audios'][entry.key]['data'],
        );
        Audio audioPath = Audio.loadFromByteData(
          ByteData.sublistView(
            soundBuffer,
          ),
          // onDuration: (seg) => audiosSegs.add(seg.toInt()),
        );

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
