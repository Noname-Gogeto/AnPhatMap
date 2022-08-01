import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';

Widget roundImageFromAssset(String image, double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: CircleAvatar(
      backgroundColor: themeColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(image),
          ),
        ),
      ),
    ),
  );
}
Widget roundImageFromNetwork(String image, double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: CircleAvatar(
      backgroundColor: themeColor,
      backgroundImage: NetworkImage(image),
    ),
  );
}