import 'dart:typed_data';

import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class Word {
  final String name;
  final String audioPath;
  final Uint8List imagePath;
  final List<Syllable> syllables;
  final List<bool> syllablesChoosed;

  const Word({
    this.name,
    this.audioPath,
    this.imagePath,
    this.syllables,
    this.syllablesChoosed,
  });
}
