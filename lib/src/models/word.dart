import 'dart:typed_data';

import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class Word {
  final String name;
  final List<Audio> audioPath;
  final Uint8List imagePath;
  final List<Syllable> syllables;
  final List<bool> syllablesChoosed;
  List<int> audiosSegs;
  final Audio wordAudio;
  int wordAudioSegs;

  Word({
    this.name,
    this.audioPath,
    this.imagePath,
    this.syllables,
    this.syllablesChoosed,
    this.wordAudio,
    this.wordAudioSegs,
  });
}
