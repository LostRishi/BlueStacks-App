import 'controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'userdetails.dart';
import 'package:get/get.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      home: FutureBuilder(
        future: authController.tryAutoLogin(),
        builder: (context, authResult) {
          if (authResult.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red));
          } else {
            if (authResult.data == true) {
              return UserDetails();
            }
            return LoginPage();
          }
        },
      ),
      routes: {
        'login': (context) => LoginPage(),
        'userdetails': (context) => UserDetails(),
      },
    );
  }
}
