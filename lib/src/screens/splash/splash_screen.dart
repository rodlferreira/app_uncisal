import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check if user was already authenticated
    Future.delayed(
      Duration(
        seconds: 2,
      ),
      () => _getAuthToken(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Image.asset(
              'assets/images/logo/pygus-logo.png',
              height: 100,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  void _getAuthToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: 'authentication_token');
    if (token != null) {
      Get.offNamed('/home');
    } else {
      Get.offNamed('/login');
    }
  }
}
