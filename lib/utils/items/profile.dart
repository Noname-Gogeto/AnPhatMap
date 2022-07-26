// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

Widget profileOptionItem(IconData icon, String label, Function()? function, bool danger) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    padding: EdgeInsets.all(10),
    child: TextButton(
      onPressed: function, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: danger ? Colors.red : Colors.black,
                  ),
                  Text(
                    ' $label',
                    style: TextStyle(
                      fontSize: 18,
                      color: danger ? Colors.red : Colors.black
                    )
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
            Icon(
              Icons.arrow_forward_ios,
              size: 25,
              color: danger ? Colors.red : Colors.black 
            )
            ]
          ),
        ]
      ),
    )
  );
}