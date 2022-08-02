// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/images/round_image.dart';

Widget defaultTextButton(String text, Function()? function) {
  return TextButton(
      onPressed: function,
      child: Text(text,
          style: TextStyle(
            color: componentPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          )));
}

Widget bottomMenuItem(
    String text, IconData icon, Function()? function, bool active) {
  return TextButton(
    onPressed: function,
    child: Column(
      children: [
        Icon(icon,
            size: 30,
            color: active ? themeColor : Color.fromRGBO(169, 169, 169, 1)),
        Text(text,
            style: TextStyle(
                fontSize: 16,
                color: active ? themeColor : Color.fromRGBO(169, 169, 169, 1)))
      ],
    ),
  );
}

Widget roundTextButtonIconWithBottomLabel(String linkImage, String label) {
  return TextButton(
    onPressed: () {},
    child: Column(children: [
      roundImageFromAssset(linkImage, 50, 50),
      Text(label, style: TextStyle(color: themeColor))
    ]),
  );
}

Widget contentHeader(String header, Function()? function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
      TextButton(
          onPressed: function,
          child: Text('Thêm',
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ))),
    ],
  );
}

Widget contentHeaderWithoutAdd(String header) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Text(header,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )),
  );
}

Widget contentHeaderTitle(String header) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Text(header,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
        )),
  );
}

Widget contentHeaderSubtitle(String header) {
  return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Icon(Icons.person),
          Text(' ' + header,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                  fontStyle: FontStyle.italic)),
        ],
      ));
}

Widget contentHeaderEdit(String header, Function()? function) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(header,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
      TextButton(
          onPressed: function,
          child: Text('Sửa',
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ))),
    ],
  );
}

Widget functinalButton(
    IconData icon, String label, bool enable, Function()? function) {
  return SizedBox(
      height: 80,
      width: 80,
      child: TextButton(
          onPressed: enable ? function : () {},
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: enable ? themeColor : buttonPrimaryColorDeactive,
              ),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: enable ? themeColor : buttonPrimaryColorDeactive))
            ],
          )));
}

Widget dataToTextFieldWithLableInDialog(
    String label, String value, bool readOnly, BuildContext context,
    {String? inputType = 'text', TextEditingController? textController}) {
  return Container(
    // padding: const EdgeInsets.only(top: 10, bottom: 10),
    // padding: const EdgeInsets.only(top: 10),
    width: MediaQuery.of(context).size.width - 100,
    // decoration: const BoxDecoration(
    //     border: Border(bottom: BorderSide(color: Colors.grey))),
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: TextFormField(
            style: TextStyle(fontSize: 13),
            onTap: inputType == 'date'
                ? () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 3, 5),
                        maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      textController!.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                  }
                : () {},
            controller: textController,
            readOnly: readOnly,
            minLines: 1,
            maxLines: 5,
            // cursorColor: componentPrimaryColor,

            enableInteractiveSelection: false,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              labelText: label,
              labelStyle: TextStyle(color: themeColor, fontSize: 13),
              hintText: value,
              hintStyle: TextStyle(color: Colors.black, fontSize: 13),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonPrimaryColorDeactive),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonPrimaryColorDeactive),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              fillColor: Color.fromRGBO(250, 250, 250, 1),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget dataToTextFieldWithLable2(
  String label,
  String value,
  bool readOnly,
  BuildContext context, {
  String? inputType = 'text',
  TextEditingController? textController,
  bool? highContrast = false,
  double sizeWidth = 0,
}) {
  TextInputType keyboardInputType = TextInputType.text;
  switch (inputType) {
    case 'password':
      keyboardInputType = TextInputType.visiblePassword;
      break;
    case 'number':
      keyboardInputType = TextInputType.number;
      break;
    default:
      break;
  }
  return Container(
    margin: const EdgeInsets.only(bottom: 5, top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: (sizeWidth == 0)
              ? MediaQuery.of(context).size.width - 20
              : sizeWidth,
          child: TextFormField(
            style: TextStyle(fontSize: 13),
            onTap: inputType == 'date'
                ? () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1900, 3, 5),
                        maxTime: DateTime.now(), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      textController!.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    }, currentTime: DateTime.now(), locale: LocaleType.vi);
                  }
                : () {},
            controller: textController,
            readOnly: readOnly,
            keyboardType: keyboardInputType,
            minLines: 1,
            maxLines: 10,
            // cursorColor: componentPrimaryColor,

            enableInteractiveSelection: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              filled: true,
              labelText: label,
              labelStyle:
                  TextStyle(color: buttonPrimaryColorActive, fontSize: 13),
              hintText: value,
              hintStyle: TextStyle(color: Colors.black, fontSize: 13),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeColor,
                    // color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: themeColor,
                    // color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              fillColor: highContrast == true
                  ? Color.fromRGBO(250, 250, 250, 1)
                  : readOnly
                      ? Colors.transparent
                      : componentTextColor,
            ),
          ),
        ),
      ],
    ),
  );
}
