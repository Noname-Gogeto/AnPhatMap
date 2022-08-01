// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';

Scaffold layout1(BuildContext context, String title, List<Widget> body) {
  return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/assets/images/main-logo.png',
                      width: MediaQuery.of(context).size.width /3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 28,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: body
                      ),
                  )
                ],
              ),
            ],
          ),
        )
      )
    ); 
}