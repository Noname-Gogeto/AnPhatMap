// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
Widget loadingScreen() {
  return Scaffold(
    backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('lib/assets/images/loading.gif')
      ],
    )
  );
}