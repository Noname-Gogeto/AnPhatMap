import 'package:flutter/material.dart';

Widget horizontalListView(double height, List<Widget> widgets) {
  return Container(
    height: height,
    child: ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: widgets,
    ),
  );
}