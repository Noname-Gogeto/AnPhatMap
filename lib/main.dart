import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/views/landing/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AnPhatMap',
        theme: ThemeData(fontFamily: 'Roboto').copyWith(
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: themeColor,
        ),
        home: const LoginScreen());
  }
}
