// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rcore/utils/color/theme.dart';

Widget defaultTextFieldWithLabel(String label, String hintText, String type,
    TextEditingController textController) {
  TextInputType inputType = TextInputType.text;
  switch (type) {
    case 'password':
      inputType = TextInputType.visiblePassword;
      break;
    case 'number':
      inputType = TextInputType.number;
      break;
    default:
      break;
  }
  return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(label,
                  style: TextStyle(
                    color: textLabelColor,
                    fontSize: 14,
                  ))),
          TextField(
              controller: textController,
              cursorColor: componentPrimaryColor,
              obscureText: type == 'password',
              enableSuggestions: !(type == 'password'),
              autocorrect: !(type == 'password'),
              keyboardType: inputType,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: hintText,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: componentPrimaryColor)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: componentSecondarycolor))),
              style: TextStyle(
                color: Colors.black,
              ))
        ],
      ));
}

Widget roundTextFieldWithLabel(String label, String hintText, String type,
    TextEditingController textController) {
  TextInputType inputType = TextInputType.text;
  switch (type) {
    case 'password':
      inputType = TextInputType.visiblePassword;
      break;
    case 'number':
      inputType = TextInputType.number;
      break;
    default:
      break;
  }
  return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(label,
                  style: TextStyle(
                    color: textLabelColor,
                    fontSize: 14,
                  ))),
          TextField(
              controller: textController,
              cursorColor: componentPrimaryColor,
              obscureText: type == 'password',
              enableSuggestions: !(type == 'password'),
              autocorrect: !(type == 'password'),
              keyboardType: inputType,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: componentButtonBackground,
                  filled: true),
              style: TextStyle(
                color: Colors.black,
              ))
        ],
      ));
}

Widget textFieldWithPrefixIcon(String hintText, IconData icon, String type,
    TextEditingController textController, BuildContext context,
    {bool readOnly = false}) {
  TextInputType inputType = TextInputType.text;
  switch (type) {
    case 'password':
      inputType = TextInputType.visiblePassword;
      break;
    case 'number':
      inputType = TextInputType.number;
      break;
    default:
      break;
  }
  return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Theme(
              data: Theme.of(context).copyWith(primaryColor: themeColor),
              child: TextField(
                  onTap: type == 'date'
                      ? () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 3, 5),
                              maxTime: DateTime.now(), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            textController.text =
                                DateFormat('dd/MM/yyyy').format(date);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.vi);
                        }
                      : () {},
                  readOnly: readOnly,
                  controller: textController,
                  cursorColor: componentPrimaryColor,
                  obscureText: type == 'password',
                  enableSuggestions: !(type == 'password'),
                  autocorrect: !(type == 'password'),
                  keyboardType: inputType,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: hintText,
                      prefixIcon: Icon(
                        icon,
                        color: themeColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color.fromRGBO(250, 250, 250, 1),
                      filled: true),
                  style: TextStyle(
                    color: Colors.black,
                  )))
        ],
      ));
}

Widget textFieldWithPasswordFormat(
    String hintText,
    Function()? func,
    bool isObscure,
    TextEditingController textController,
    BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    child: Column(
      children: [
        Theme(
            data: Theme.of(context).copyWith(primaryColor: themeColor),
            child: TextField(
                controller: textController,
                cursorColor: componentPrimaryColor,
                obscureText: isObscure,
                enableSuggestions: !isObscure,
                autocorrect: !isObscure,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: hintText,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: themeColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: func,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeColor),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    fillColor: Color.fromRGBO(250, 250, 250, 1),
                    filled: true),
                style: TextStyle(
                  color: Colors.black,
                )))
      ],
    ),
  );
}

Widget textFieldWithPlaceholder(
    String hintText,
    String type,
    TextEditingController textController,
    BuildContext context,
    Function()? onChanged) {
  TextInputType inputType = TextInputType.text;
  switch (type) {
    case 'password':
      inputType = TextInputType.visiblePassword;
      break;
    case 'number':
      inputType = TextInputType.number;
      break;
    case 'multiline':
      inputType = TextInputType.multiline;
      break;
    default:
      break;
  }
  return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Theme(
              data: Theme.of(context).copyWith(primaryColor: themeColor),
              child: TextField(
                  onEditingComplete: onChanged,
                  maxLines: type == 'multiline' ? 7 : 1,
                  onTap: type == 'date'
                      ? () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 3, 5),
                              maxTime: DateTime.now(), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            textController.text =
                                DateFormat('dd/MM/yyyy').format(date);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.vi);
                        }
                      : () {},
                  controller: textController,
                  cursorColor: componentPrimaryColor,
                  obscureText: type == 'password',
                  enableSuggestions: !(type == 'password'),
                  autocorrect: !(type == 'password'),
                  keyboardType: inputType,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: hintText,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: themeColor),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color.fromRGBO(250, 250, 250, 1),
                      filled: true),
                  style: TextStyle(
                    color: Colors.black,
                  )))
        ],
      ));
}
