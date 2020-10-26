import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/models/word.dart';

class HomeController extends GetxController {

  final AudioCache audioCache = AudioCache();
  
  final Word word = const Word(
    name: 'Boca',
    imagePath: 'assets/images/words/boca.jpg',
    syllables: [
      Syllable(
        name: 'BO',
        audioPath: 'assets/audio/bo.mp3'
      ),
      Syllable(
        name: 'CA',
      )
    ]
  );

  final RxList<Syllable> randomSyllables = RxList();
  bool get isCompleted => randomSyllables?.length != null ? randomSyllables?.length == 0 : false;

  @override
  void onInit() {
    ever(randomSyllables, (_) => isCompleted ? completed() : null);
    super.onInit();
  }

  @override
  void onReady() {
    randomSyllables.value = createRandomSyllables(word.syllables);
    super.onReady();
  }

  void completed() {
    Get.dialog(
      AlertDialog(
        title: Text('Você conseguiu, parabéns'),
      )
    );
    playWordAudio();
  }

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

  Future<void> playWordAudio() => playAudio(word.audioPath);
  Future<void> playSyllableAudio(Syllable syllable) => playAudio(syllable.audioPath);
  Future<void> playAudio(String audioPath) async {
    if (audioPath != null)
      await audioCache.play(audioPath.substring(7));
  }

  reset() {
    randomSyllables.value = createRandomSyllables(word.syllables);
  }

  bool onWillAccept(Syllable syllable, Syllable dropSyllable) 
    => syllable.name == dropSyllable.name;

  void onAccept(Syllable syllable) {
    playSyllableAudio(syllable);
    randomSyllables.remove(syllable);
  }

}