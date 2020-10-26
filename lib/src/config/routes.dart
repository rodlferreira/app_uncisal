import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/home/home_bindings.dart';
import 'package:prototipo_app_uncisal/src/screens/home/home_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/login/login_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/splash/splash_screen.dart';

final List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => SplashScreen()
  ),
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
    binding: HomeBindings()
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen()
  )
];