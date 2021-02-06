import 'package:prototipo_app_uncisal/src/models/syllable.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_button.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_draggable.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_target.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: RaisedButton(
                          onPressed: () {
                            Get.offNamed('/home');
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          color: Color.fromRGBO(
                            222,
                            184,
                            33,
                            1,
                          ),
                          textColor: Colors.white,
                          padding: EdgeInsets.all(12),
                          child: Text('Voltar'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Center(
                    child: Image.asset(
                      controller.word.imagePath,
                      fit: BoxFit.contain,
                      width: 200,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                      SyllableButton(
                        syllable: Syllable(
                          name: 'BO',
                          audioPath: 'assets/audio/bo.mp3',
                        ),
                        enable: true,
                      ),
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                      SyllableButton(
                        syllable: Syllable(
                          name: 'CA',
                          audioPath: 'assets/audio/bo.mp3',
                        ),
                        enable: true,
                      ),
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(
                0,
                143,
                151,
                1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.randomSyllables
                  .map<Widget>(
                    (Syllable syllable) => Row(
                      children: [
                        SyllableButton(
                          syllable: syllable,
                          enable: false,
                        ),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(
                  0,
                  143,
                  151,
                  1,
                ),
              ),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                color: Color.fromRGBO(
                  222,
                  184,
                  33,
                  1,
                ),
                textColor: Colors.white,
                padding: EdgeInsets.all(12),
                child: Text('Próxima'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
