// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:http/http.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';

Widget squareCheckBoxWithLabel(String label, BuildContext context,
    Function(bool?)? function, bool? checkBoxValue) {
  // Checkbox Theme
  final theme = Theme.of(context);
  final oldCheckboxTheme = theme.checkboxTheme;

  final newCheckBoxTheme = oldCheckboxTheme.copyWith(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    fillColor: MaterialStateProperty.all<Color>(componentPrimaryColor),
  );
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    child: Theme(
        data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                checkColor: componentTextColor,
                value: checkBoxValue,
                onChanged: function,
              ),
            ),
            Text(label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ))
          ],
        )),
  );
}

Future<bool> saveUser(String user) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.setString('', user);
}

// Future<dynamic> login(String username, String password) async {
//   try {
//     var res =
//         await dio.post("LOGIN-URL", body: {"user": username, "pass": password});

//     if (res.statusCode == 200) {
//       final userIsStored = await saveUser(jsonEncode(res.data));

//       if (userIsStored) {
//         print('USER HAS BE STORED TO SHAREDPREFERENCES');
//       }
//       user.fromJson(res.data);
//     } else {}
//   } catch (e) {
//     throw e.toString();
//   }
// }
