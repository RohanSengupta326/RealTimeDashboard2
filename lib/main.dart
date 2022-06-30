import 'package:flutter/material.dart';
import 'package:login/auth.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogIn',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(1, 53, 80, 1),
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.blue,
              onPrimary: Color.fromRGBO(185, 84, 81, 1),
              secondary: Color.fromRGBO(255, 217, 102, 1),
              onSecondary: Colors.black,
              error: Color.fromRGBO(185, 84, 81, 1),
              onError: Colors.white,
              surface: Colors.amberAccent,
              onSurface: Color.fromRGBO(146, 149, 102, 1),
              background: Colors.black,
              onBackground: Colors.white),
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))),
      home: AuthPage(),
    );
  }
}
