import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter/foundation.dart';

class Syllable {
  final String id;
  final String name;
  final Audio audioPath;
  final bool isPhoneme;

  const Syllable({
    this.id,
    @required this.name,
    this.audioPath,
    this.isPhoneme,
  });
}
