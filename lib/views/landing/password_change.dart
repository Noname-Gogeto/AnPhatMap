// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/dialogs/dialog.dart';
import '../../utils/text_input/text_input.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  const ChangePasswordScreen({
    Key? key,
    this.userInfo,
  }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordComfirmController = TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;
  bool isObscure3 = true;

  get themeColor => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset('lib/assets/images/main-logo.png',
                        width: MediaQuery.of(context).size.width / 3)),
                Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 30),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Đổi mật khẩu',
                            style: TextStyle(
                              fontSize: 24,
                              color: themeColor,
                              fontWeight: FontWeight.bold,
                            )))),
                textFieldWithPasswordFormat('Mật khẩu cũ', () {
                  setState(() {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  });
                }, isObscure, oldPasswordController, context),
                textFieldWithPasswordFormat('Mật khẩu mới', () {
                  setState(() {
                    setState(() {
                      isObscure2 = !isObscure2;
                    });
                  });
                }, isObscure2, newPasswordController, context),
                textFieldWithPasswordFormat('Nhập lại mật khẩu', () {
                  setState(() {
                    setState(() {
                      isObscure3 = !isObscure3;
                    });
                  });
                }, isObscure3, passwordComfirmController, context),
                primarySizedButton(
                  'Đặt lại mật khẩu',
                  context,
                  () {
                    if (newPasswordController.text !=
                        passwordComfirmController.text) {
                      notiDialog(
                          'Thông báo',
                          'Xác nhận mật khẩu không chính xác',
                          () => Navigator.pop(context),
                          context);
                    } else {
                      GetAPI(
                          'https://anphat.andin.io/index.php?r=restful-api/doi-mat-khau',
                          context,
                          'POST', {
                        'auth': widget.userInfo!['auth_key'],
                        'uid': widget.userInfo!['id'].toString(),
                        'passwordOld': oldPasswordController.text,
                        'passwordNew': newPasswordController.text,
                      }).then((Map<String, dynamic>? json) => ({
                            if (json != null)
                              {
                                notiDialog('Thông báo', json['message'],
                                    () async {
                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'userInfo', jsonEncode(json['data']));
                                  Navigator.of(context).pop();
                                }, context)
                              }
                          }));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
