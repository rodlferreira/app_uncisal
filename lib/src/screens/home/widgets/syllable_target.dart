import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/shared/widgets/empty_box.dart';

import '../home_controller.dart';
import 'syllable_button.dart';

class SyllableTarget extends StatelessWidget {

  final Syllable syllable;
  final bool dropped;

  const SyllableTarget({Key key, @required this.syllable, this.dropped=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dropped) {
      return Container(
        height: 100,
        width: 90,
        color: Colors.green,
        alignment: Alignment.center,
        child: SyllableButton(
          syllable: syllable,
        ),
      );
    }
    return Container(
      height: 100,
      width: 90,
      color: Colors.red,
      child: DragTarget<Syllable>(
        builder: (BuildContext context, List<Syllable> syllables, List<dynamic> rejected) 
          => kEmptyBox,
        onAccept: (Syllable dropSyllable) {
          Get.find<HomeController>().onAccept(dropSyllable);
        },
        onWillAccept: (dropSyllable) => 
          Get.find<HomeController>().onWillAccept(syllable, dropSyllable),
      ),
    );
  }
}