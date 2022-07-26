// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget borderCornerImageFromAsset(String link, BuildContext context, double width, double height) {
  return Container(
    width: width < 0 ? MediaQuery.of(context).size.width : width,
    height: height < 0 ? MediaQuery.of(context).size.height : height,
    margin: EdgeInsets.only(left:10,right:10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(link),
      ),
    ),
  );
}
Widget borderCornerImageFromNetwork(String link, BuildContext context, double width, double height) {
  return Container(
    width: width < 0 ? MediaQuery.of(context).size.width : width,
    height: height < 0 ? MediaQuery.of(context).size.height : height,
    margin: EdgeInsets.only(left:10,right:10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(link),
      ),
    ),
  );
}

Widget borderCornerImagePicker(File? file, Function()? function) {
  return Container(
    width: 150,
    height: 150,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      image: file != null ? (
        DecorationImage(
          fit: BoxFit.fill,
          image:  FileImage(file),
        )) : (DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('lib/assets/images/picture-placeholder.jpg'),
        )),
      ),
      child: TextButton(
        onPressed: function,
        child: Container(),
      ),
    );
}