// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordComfirmController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  // String textType = 'password';
  // bool hidePassword = false;
  // dynamic showPass(value) {
  //   setState(() {
  //     textType = (hidePassword == false) ? 'text' : 'password';
  //     hidePassword = !hidePassword;
  //   });
  // }
  bool isObscure = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset('lib/assets/images/main-logo.png',
                  width: MediaQuery.of(context).size.width / 3)),
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 30),
              child: Align(
                  alignment: Alignment.center,
                  child: Text('Đăng ký',
                      style: TextStyle(
                        fontSize: 24,
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                      )))),
          textFieldWithPrefixIcon('Tên đăng nhập', Icons.person, 'text',
              usernameController, context),
          textFieldWithPasswordFormat('Mật khẩu', () {
            setState(() {
              setState(() {
                isObscure = !isObscure;
              });
            });
          }, isObscure, passwordController, context),
          textFieldWithPasswordFormat('Xác nhận mật khẩu', () {
            setState(() {
              isObscure2 = !isObscure2;
            });
          }, isObscure2, passwordComfirmController, context),
          textFieldWithPrefixIcon(
              'Họ tên', Icons.person_add, 'text', fullNameController, context),
          textFieldWithPrefixIcon(
              'Email', Icons.email, 'text', emailController, context),
          textFieldWithPrefixIcon('Số điện thoại', Icons.phone, 'text',
              phoneNumberController, context),
          textFieldWithPrefixIcon('Ngày sinh', Icons.date_range_outlined,
              'date', birthdayController, context),
          // squareCheckBoxWithLabel(
          //     'Hiển thị mật khẩu', context, showPass, hidePassword),
          primarySizedButton(
            'Đăng ký',
            context,
            () {
              if (passwordController.text != passwordComfirmController.text) {
                notiDialog('Thông báo', 'Xác nhận mật khẩu không chính xác',
                    () => Navigator.pop(context), context);
              } else {
                GetAPI(
                    'https://anphat.andin.io/index.php?r=restful-api/dang-ki-tai-khoan',
                    context,
                    'POST', {
                  'username': usernameController.text,
                  'password': passwordController.text,
                  'hoten': fullNameController.text,
                  'dien_thoai': phoneNumberController.text,
                  'email': emailController.text,
                  'ngay_sinh': birthdayController.text,
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
              }
            },
          ),
          defaultTextButton(
              'Đã có tài khoản? Đăng nhập',
              () => Navigator.of(context)
                  .pop(MaterialPageRoute(builder: (context) => LoginScreen())))
        ]),
      ),
    ));
  }
}
