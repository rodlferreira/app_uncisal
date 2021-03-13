import 'package:flutter/material.dart';
import 'package:glitters/glitters.dart';
import 'package:prototipo_app_uncisal/src/models/syllable.dart';

class SyllableButton extends StatefulWidget {
  Syllable syllable;
  bool enable;
  bool isFonetic;
  Color color;

  SyllableButton({
    Key key,
    this.syllable,
    this.enable,
    this.isFonetic,
    this.color,
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
      child: Stack(
        children: [
          Container(
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
              // color: widget.isFonetic == true ? Colors.green : Colors.white,
              color: widget.color,
            ),
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.syllable.name,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.isFonetic == true ? Colors.white : null,
                  fontWeight: widget.isFonetic == true ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
          widget.isFonetic == true
              ? Glitters(
                  interval: Duration(milliseconds: 300),
                  maxOpacity: 0.7,
                  color: Colors.orange,
                )
              : Container(),
          widget.isFonetic == true
              ? Glitters(
                  duration: Duration(milliseconds: 200),
                  outDuration: Duration(milliseconds: 500),
                  interval: Duration.zero,
                  color: Colors.white,
                  maxOpacity: 0.5,
                )
              : Container(),
        ],
      ),
    );
  }
}
