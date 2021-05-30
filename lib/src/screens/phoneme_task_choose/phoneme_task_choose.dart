import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/tasks_list/task_load_screen.dart';

class PhonemeTaskChoose extends StatefulWidget {
  final tasksByPhoneme;
  PhonemeTaskChoose({
    this.tasksByPhoneme,
  });

  @override
  _PhonemeTaskChooseState createState() => _PhonemeTaskChooseState();
}

class _PhonemeTaskChooseState extends State<PhonemeTaskChoose> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(
          0,
          143,
          151,
          1,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 60,
                  bottom: 5,
                ),
                child: Text(
                  'Fonemas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 20,
                ),
                child: Text(
                  'Escolha abaixo um dos fonemas para praticar.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Wrap(
                children: widget.tasksByPhoneme
                    .asMap()
                    .entries
                    .map<Widget>(
                      (el) => Container(
                        padding: EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: RaisedButton(
                          onPressed: () {
                            Get.to(
                              () => TaskLoadScreen(
                                tasks: el.value['tasks'],
                                index: 0,
                              ),
                            );
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
                          child: Text(el.value['phoneme'].toUpperCase()),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Text('Escolher outro nível'),
                  onPressed: () {
                    Get.offNamed('/home');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
