import 'package:flutter/material.dart';

class SyllableButton extends StatelessWidget {

  final String syllable;

  const SyllableButton({Key key, this.syllable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(syllable);
      },
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          syllable,
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}