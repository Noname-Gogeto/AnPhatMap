// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/drawer/drawer.dart';
import 'package:rcore/utils/images/round_image.dart';
import 'package:rcore/utils/items/home.dart';

Scaffold layout2(GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context, String title, List<Widget> body, String activeName, Map<String, dynamic> userInfo) {
  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black
        )
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, // <-- SEE HERE
      ),
      leading: Container(padding: EdgeInsets.all(6), child: Image.asset('lib/assets/images/main-logo.png')),
      actions: [
        IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          }, 
          icon:  Icon(Icons.list)
        )
      ],
    ),
    drawer: Drawer(
      child: ListView(
        children: [
          drawerHeader('lib/assets/images/barber1.jpg', userInfo['hoten'].toString(), 'Quản trị viên', () {
          }),
          drawerItem('Phân quyền', Icons.settings, activeName == 'permission', () {}),
          drawerItem('Thoát', Icons.logout, activeName == 'logout', () {
            yesNoDialog('Cảnh báo', 'Bạn có muốn thoát ứng dụng ?', () {
              deleteFile(context).then((value) => ({
                exit(0),


              }));
            }, () {
              Navigator.pop(context);
            }, context);
          }),
        ],
      ),
    ),
    body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
  ); 
}