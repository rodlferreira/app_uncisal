import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'src/config/routes.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: routes,
      initialRoute: '/',
    );
  }
}
