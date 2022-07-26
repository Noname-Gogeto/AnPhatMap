// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';

Widget pageNavigator(Function()? pressBack, Function()? pressForward,
    TextEditingController controller, int maxPage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(
          onPressed: pressBack,
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
            decoration: BoxDecoration(
                color: int.parse(controller.text) <= 1
                    ? buttonPrimaryColorDeactive
                    : themeColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          )),
      Container(
        width: 100,
        child: TextField(
          enabled: false,
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              hintText: 'Page number',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              fillColor: Color.fromRGBO(250, 250, 250, 1),
              filled: true),
        ),
      ),
      TextButton(
          onPressed: pressForward,
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
            decoration: BoxDecoration(
                color: int.parse(controller.text) >= maxPage
                    ? buttonPrimaryColorDeactive
                    : themeColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          )),
    ],
  );
}
