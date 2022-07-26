// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
Widget primarySizedButton(String text, BuildContext context, Function()? function) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 55,
    child: ElevatedButton(
      child: Text(text),
      onPressed: function,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(buttonPrimaryColorText),
        backgroundColor: MaterialStateProperty.all<Color>(buttonPrimaryColorActive),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: BorderSide(color: themeColor)
          )
        ),
      )
    ),
  );
}
Widget successSizedButton(String text, BuildContext context, Function()? function) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 55,
    child: ElevatedButton(
      child: Text(text),
      onPressed: function,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(componentTextColor),
        backgroundColor: MaterialStateProperty.all<Color>(successColor),
        side: MaterialStateProperty.all(BorderSide(
          color: componentButtonBorder
        ))
      ),
      
    ),
  );
}
Widget customSizedButton(String text, BuildContext context, IconData icon, Color color, double radius, Function()? function) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 55,
    child: ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(' ' + text),
        ],
      ),
      onPressed: function,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(buttonPrimaryColorText),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: color)
          )
        ),
      )
    ),
  );
}