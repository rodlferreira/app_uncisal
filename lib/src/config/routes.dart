import 'package:get/get.dart';
import 'package:prototipo_app_uncisal/src/screens/splash/splash_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/login/login_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/signup/signup_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/level_choose/level_choose.dart';
import 'package:prototipo_app_uncisal/src/screens/home/home_screen.dart';
import 'package:prototipo_app_uncisal/src/screens/success_level/success_level_screen.dart';

final List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => SplashScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
  ),
  GetPage(
    name: '/signup',
    page: () => SignupScreen(),
  ),
  GetPage(
    name: '/home',
    page: () => LevelChoose(),
  ),
  GetPage(
    name: '/task',
    page: () => HomeScreen(),
  ),
  GetPage(
    name: '/success',
    page: () => SuccessLevelScreen(),
  ),
];
