import 'package:flutter/material.dart';

Widget verticalListView(double height, List<Widget> widgets) {
  return Container(
    height: height,
    child: ListView(
      children: widgets,
    ),
  );
}