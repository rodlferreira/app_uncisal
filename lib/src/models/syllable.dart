import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/foundation.dart';

class Syllable {
  final String name;
  final Audio audioPath;

  const Syllable({@required this.name, this.audioPath});
}
