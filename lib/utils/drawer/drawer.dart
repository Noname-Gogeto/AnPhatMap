// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/images/round_image.dart';

import '../color/theme.dart';

Widget drawerHeader(String backgroundImage, String title, String subTitle, Function()? function) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey),
      ),
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('lib/assets/images/barber1.jpg')
      )
    ),
    child: TextButton(
      onPressed: function,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              roundImageFromAssset('lib/assets/images/main-logo.png', 80, 80)
            ]
          ),
          Container(
            height: 80,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ]
            ),
          )
        ],
      ),
    )
  );
}