import 'package:flutter/material.dart';
import 'package:login/auth.dart';
import 'package:get/get.dart';
import 'package:login/homeview.dart';
import './customScroll.dart';
// for horizontal scrolling on web
import 'package:flutter/services.dart';

void main() {
//  transparent android statusbar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primaryColor: const Color(0xff003551),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.blue,
            onPrimary: Color.fromRGBO(185, 84, 81, 1),
            secondary: Color(0xffffd966),
            onSecondary: Colors.black,
            error: Color.fromRGBO(185, 84, 81, 1),
            onError: Colors.white,
            surface: Colors.amberAccent,
            onSurface: Color(0xff666a66),
            background: Colors.black,
            onBackground: Colors.white),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeView(),
    );
  }
}
