import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_draggable.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_target.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: Text('Fonoaudiologia'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.reset();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              child: Image.asset(
                controller.word.imagePath, 
                fit: BoxFit.contain,
                width: 280,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4
            ),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: controller.randomSyllables
                .map<Widget>((Syllable syllable) 
                  => SyllableDraggable(
                      syllable: syllable,
                      dropped: !controller.randomSyllables.contains(syllable)
                    )).toList()
            )),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 14, right: 14,
              top: 24
            ),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: controller.word.syllables
                  .map<Widget>((Syllable syllable) => SyllableTarget(
                      syllable: syllable, 
                      dropped: !controller.randomSyllables.contains(syllable),
                    )).toList()
              );
            }),
          ),


          const Spacer(flex: 5),
          IconButton(
            icon: Icon(
              Icons.keyboard_voice,
              color: Colors.black87,
            ),
            iconSize: 80,
            onPressed: () {
            },
          ),
          const Spacer(flex: 3),
        ],
      )
    );
  }
}