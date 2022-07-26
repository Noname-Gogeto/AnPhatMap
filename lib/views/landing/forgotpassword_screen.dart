// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/login_screen.dart';
import 'package:rcore/views/landing/signup_screen.dart';
import 'package:rcore/views/map/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/buttons/text_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset('lib/assets/images/main-logo.png',
                  width: MediaQuery.of(context).size.width / 3)),
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 30),
              child: Align(
                  alignment: Alignment.center,
                  child: Text('Quên mật khẩu',
                      style: TextStyle(
                        fontSize: 24,
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                      )))),
          textFieldWithPrefixIcon('Tên đăng nhập', Icons.person, 'text',
              usernameController, context),
          primarySizedButton(
            'Đặt lại mật khẩu',
            context,
            () {
              GetAPI(
                  'https://anphat.andin.io/index.php?r=restful-api/quen-mat-khau',
                  context,
                  'POST', {
                'username': usernameController.text,
              }).then((Map<String, dynamic>? json) => ({
                    if (json != null)
                      {
                        notiDialog('Thông báo', json['message'], () async {
                          var prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              'userInfo', jsonEncode(json['data']));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        }, context)
                      }
                  }));
            },
          ),
          defaultTextButton(
              'Đã có tài khoản? Đăng nhập',
              () => Navigator.of(context)
                  .pop(MaterialPageRoute(builder: (context) => LoginScreen())))
        ],
      ),
    ));
  }
}
