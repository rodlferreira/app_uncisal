import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class SyllableButton extends StatefulWidget {
  final Syllable syllable;
  final bool enable;

  const SyllableButton({
    Key key,
    this.syllable,
    this.enable,
  }) : super(key: key);

  @override
  _SyllableButtonState createState() => _SyllableButtonState();
}

class _SyllableButtonState extends State<SyllableButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 40,
      minWidth: 60,
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(
          //   Radius.circular(5),
          // ),
          border: Border.all(
            width: 1,
            color: Color.fromRGBO(
              0,
              143,
              151,
              1,
            ),
          ),
          color: widget.enable != false
              ? Colors.white
              : Color.fromRGBO(
                  0,
                  71,
                  77,
                  1,
                ),
        ),
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.syllable.name,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
