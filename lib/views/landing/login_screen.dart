// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/forgotpassword_screen.dart';
import 'package:rcore/views/landing/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/text_input/checkbox.dart';
import '../customers/customers_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // String textType = 'password';
  // bool hidePassword = false;
  // dynamic showPass(value) {
  //   setState(() {
  //     textType = (hidePassword == false) ? 'text' : 'password';
  //     hidePassword = !hidePassword;
  //   });
  // }

  bool isObscure = true;
  bool isSaveAcount = false;
  String? userName;
  String? password;

  saveValues() async {
    if (isSaveAcount) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("username", usernameController.text);
      prefs.setString("password", passwordController.text);
    }
  }

  getSharedPreferencesValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("username") ?? "";
    password = prefs.getString("password") ?? "";
    if (userName != '' && password != '') {
      usernameController.text = userName!;
      passwordController.text = password!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getSharedPreferencesValue();
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
                  child: Text('Đăng nhập',
                      style: TextStyle(
                        fontSize: 24,
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                      )))),
          textFieldWithPrefixIcon('Tên đăng nhập', Icons.person, 'text',
              usernameController, context),
          textFieldWithPasswordFormat('Mật khẩu', () {
            setState(() {
              isObscure = !isObscure;
            });
          }, isObscure, passwordController, context),
          squareCheckBoxWithLabel('Lưu tài khoản', context, (value) {
            isSaveAcount = value!;
          }, isSaveAcount),
          primarySizedButton(
            'Đăng nhập',
            context,
            () {
              GetAPI('https://anphat.andin.io/index.php?r=service/login',
                  context, 'POST', {
                'username': usernameController.text,
                'password_hash': passwordController.text,
              }).then((Map<String, dynamic>? json) => ({
                    if (json != null)
                      {
                        notiDialog('Thông báo', json['msg'], () async {
                          var prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              'userInfo', jsonEncode(json['data']));
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => CustomerScreen()));
                        }, context),
                        saveValues(),
                      }
                  }));
            },
          ),
          defaultTextButton(
              'Chưa có tài khoản? Đăng ký',
              () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpScreen()))),
          defaultTextButton(
              'Quên mật khẩu?',
              () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgotPasswordScreen()))),
          // GestureDetector(
          //   onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          // )
        ],
      ),
    ));
  }
}
