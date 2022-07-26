// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/text_input/text_input.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  const EditProfileScreen({
    Key? key,
    this.userInfo,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.userInfo!['hoten'];
    emailController.text = widget.userInfo!['email'];
    phoneNumberController.text = widget.userInfo!['dien_thoai'];
    birthdayController.text = widget.userInfo!['ngay_sinh'];
    addressController.text = widget.userInfo!['dia_chi'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Chỉnh sửa thông tin cá nhân',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('lib/assets/images/main-logo.png',
                        width: MediaQuery.of(context).size.width / 3),
                  ),
                  SizedBox(height: 50),
                  // Container(
                  //     margin: EdgeInsets.only(top: 50, bottom: 30),
                  //     child: Align(
                  //         alignment: Alignment.center,
                  //         child: Text('Đăng ký',
                  //             style: TextStyle(
                  //               fontSize: 24,
                  //               color: themeColor,
                  //               fontWeight: FontWeight.bold,
                  //             )))),
                  textFieldWithPrefixIcon('Họ tên', Icons.person, 'text',
                      fullNameController, context),
                  textFieldWithPrefixIcon(
                      'Email', Icons.email, 'text', emailController, context),
                  textFieldWithPrefixIcon('Số điện thoại', Icons.phone, 'text',
                      phoneNumberController, context),
                  textFieldWithPrefixIcon(
                      'Ngày sinh',
                      Icons.date_range_outlined,
                      'date',
                      birthdayController,
                      context),
                  textFieldWithPrefixIcon('Địa chỉ', Icons.home_rounded, 'text',
                      addressController, context),
                  // squareCheckBoxWithLabel(
                  //     'Hiển thị mật khẩu', context, showPass, hidePassword),
                  primarySizedButton(
                    'Cập nhật',
                    context,
                    () {
                      GetAPI(
                          'https://anphat.andin.io/index.php?r=restful-api/edit-thong-tin',
                          context,
                          'POST', {
                        'uid': widget.userInfo!['id'],
                        'auth': widget.userInfo!['auth_key'],
                        'hoTen': fullNameController.text,
                        'dienThoai': phoneNumberController.text,
                        'email': emailController.text,
                        'ngaySinh': birthdayController.text,
                        'diaChi': addressController.text,
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
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
