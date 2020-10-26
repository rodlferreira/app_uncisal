import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class Word {

  final String name;
  final String audioPath;
  final String imagePath;
  final List<Syllable> syllables;

  const Word({this.name, this.audioPath, this.imagePath, this.syllables});

}