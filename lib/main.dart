import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_app_uncisal/src/config/initial_bindings.dart';

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
      initialBinding: InitialBindings(),
    );
  }
}