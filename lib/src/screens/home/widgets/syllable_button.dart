import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class SyllableButton extends StatelessWidget {
  final Syllable syllable;
  final bool enable;

  const SyllableButton({
    Key key,
    this.syllable,
    this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 40,
      minWidth: 60,
      child: RaisedButton(
        onPressed: enable ? () {} : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Text(
          syllable.name,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
