import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/screens/home/widgets/syllable_button.dart';

class HomeScreen extends StatelessWidget {

  static const String _imageUrl = 'https://images.vexels.com/media/users/3/158265/isolated/preview/62610dcc828ec36764fc4bc18eb6a380-falando-f-mea-boca---cone-by-vexels.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fonoaudiologia'),
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
              child: Image.network(
                _imageUrl,
                width: 280,
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SyllableButton(
                  syllable: 'BO'
                ),
                SyllableButton(
                  syllable: 'CA'
                ),
              ],
            ),
          ),

          const Spacer(flex: 5),
          IconButton(
            icon: Icon(
              Icons.keyboard_voice,
              color: Colors.grey,
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