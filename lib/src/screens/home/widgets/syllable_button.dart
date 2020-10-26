import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class SyllableButton extends StatelessWidget {

  final Syllable syllable;
  final bool show;

  const SyllableButton({Key key, this.syllable, this.show}) : super(key: key);

  static const EdgeInsets _padding = const EdgeInsets.all(12);
  static const double _fontSize = 50;

  @override
  Widget build(BuildContext context) {
    if (show != null && !show) {
      return Padding(
        padding: _padding,
        child: Text(
          syllable.name,
          style: TextStyle(
            fontSize: _fontSize,
            color: Colors.transparent
          ),
        )
      );
    }
    return InkWell(
      // onTap: () => Get.find<HomeController>().play(syllable),
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      child: Padding(
        padding: _padding,
        child: Text(
          syllable.name,
          style: TextStyle(
            fontSize: _fontSize,
          ),
        ),
      ),
    );
  }
}