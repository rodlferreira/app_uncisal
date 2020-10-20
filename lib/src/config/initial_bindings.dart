import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {

    Future.delayed(
      Duration(milliseconds: 300),
      () => Get.offNamed('/login')
    );
  }
}