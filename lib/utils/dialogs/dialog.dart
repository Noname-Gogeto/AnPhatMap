// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/text_input/text_input.dart';

/// NotiDialog(String title, String content, Function()? function, BuildContext context)
///
/// The function takes in 4 parameters:
///
/// 1. title: The title of the dialog box.
/// 2. content: The content of the dialog box.
/// 3. function: The function to be executed when the user clicks the close button.
/// 4. context: The context of the current screen
///
/// Args:
///   title (String): The title of the dialog
///   content (String): The content of the dialog
///   function (Function()?): Function()?
///   context (BuildContext): The context of the widget that calls the function
void notiDialog(
    String title, String content, Function()? function, BuildContext context) {
  //*, Future<Null> Function() param4) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
          child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  Text(content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: function,
                        child:
                            Text('Close', style: TextStyle(color: themeColor))),
                  )
                ],
              ))));
}

/// It takes a title, content, functionYes, functionNo, and context as parameters and displays a dialog
/// with a title, content, and two buttons that call the functionYes and functionNo functions when
/// pressed
///
/// Args:
///   title (String): The title of the dialog
///   content (String): The content of the dialog
///   functionYes (Function()?): The function to be called when the user clicks on the Yes button.
///   functionNo (Function()?): The function to be called when the user clicks on the No button.
///   context (BuildContext): The context of the current screen.
void yesNoDialog(String title, String content, Function()? functionYes,
    Function()? functionNo, BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
          child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  Text(content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                        onPressed: functionYes,
                        child:
                            Text('Yes', style: TextStyle(color: themeColor))),
                    TextButton(
                        onPressed: functionNo,
                        child: Text('No', style: TextStyle(color: themeColor))),
                  ])
                ],
              ))));
}
