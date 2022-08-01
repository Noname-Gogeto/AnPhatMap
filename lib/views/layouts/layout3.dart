// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/images/round_image.dart';

Scaffold layout3(BuildContext context, String title, List<Widget> body, Function()? function) {
  return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //Header
          Container(
            height: 80,
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: TextButton(
                    onPressed: function,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  )
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 90,
            child: Column(
              children: [
                Expanded(
                  //Body
                  child: Container(
                    height: MediaQuery.of(context).size.height - 82,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(252, 252, 252, 1),
                    ),
                    child: ListView(
                      children: body,
                    ),
                  ),
                ),
              ]
            )
          )
        ],
      ),
    )
  );
}
