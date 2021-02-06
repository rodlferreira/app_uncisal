import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

import 'syllable_button.dart';

class SyllableDraggable extends StatelessWidget {
  final Syllable syllable;
  final bool dropped;

  const SyllableDraggable({
    Key key,
    @required this.syllable,
    this.dropped = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dropped) {
      return SyllableButton(
        syllable: syllable,
        // show: false,
      );
    }
    final Widget btn = SyllableButton(syllable: syllable);
    return Draggable<Syllable>(
      data: syllable,
      child: btn,
      childWhenDragging: SyllableButton(
        syllable: syllable,
        // show: false,
      ),
      feedback: Material(
        color: Colors.transparent,
        child: SyllableButton(syllable: syllable),
      ),
      // onDragStarted: () => controller.play(syllableWrapper.syllable),
    );
  }
}
