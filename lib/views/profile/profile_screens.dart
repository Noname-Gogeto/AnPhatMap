// ignore_for_file: prefer_const_constructors, avoid_init_to_null, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/views/landing/password_change.dart';
import 'package:rcore/views/profile/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/buttons/button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool isLoadedData = false;
  // Map<String, dynamic>? jsonData = null;
  // Map<String, dynamic>? userInfo = null;

  // void getData() {
  //   if (!isLoadedData) {
  //     SharedPreferences.getInstance().then((prefs) => ({
  //           print("BEFORE: $userInfo"),
  //           print("DATA: ${prefs.getString('userInfo')}"),
  //           userInfo = jsonDecode(prefs.getString('userInfo')!),
  //           print("TEMP: $userInfo"),
  //           setState(() {
  //             isLoadedData = true;
  //           }),
  //         }));
  //   }
  // }

  Widget twoTextBetween(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(5),
      // decoration: const BoxDecoration(
      //     border: Border(bottom: BorderSide(color: Colors.grey))),
      // margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:',
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(
                fontSize: 13,
              )),
        ],
      ),
    );
  }

  Widget getUserInfo(String lable, String value) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(255, 244, 242, 242),
      // color: themeColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: twoTextBetween(lable, value),
      ),
    );
  }

  Map<String, dynamic>? userInfo = null;
  bool isLoadedData = false;

  void getDataUser() {
    if (!isLoadedData) {
      SharedPreferences.getInstance().then((prefs) => ({
            print("BEFORE: $userInfo"),
            print("DATA: ${prefs.getString('userInfo')}"),
            userInfo = jsonDecode(prefs.getString('userInfo')!),
            print("TEMPX: $userInfo"),
            setState(() {
              isLoadedData = true;
            }),
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataUser();
    // return profileOptionItem(Icons.person, 'hihi', (() {}), true);
    // getData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Thông tin cá nhân',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 242, 242),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 244, 242, 242),
          // color: themeColor,
          child: ListView(
            children: userInfo == null
                ? []
                : [
                    SizedBox(
                      height: 125,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color.fromRGBO(255, 217, 0, 1),
                        child: userInfo!['anh_nguoi_dung'] == null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            : Image.asset(userInfo!['anh_nguoi_dung']),
                      ),
                    ),
                    const SizedBox(height: 20),
                    getUserInfo('Username', userInfo!['username']),
                    getUserInfo('Họ tên', userInfo!['hoten']),
                    getUserInfo('Email', userInfo!['email']),
                    getUserInfo('Điện thoại', userInfo!['dien_thoai']),
                    getUserInfo('Ngày sinh', userInfo!['ngay_sinh']),
                    getUserInfo('Địa chỉ', userInfo!['dia_chi']),
                    primarySizedButton(
                      'Chỉnh sửa',
                      context,
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                                  userInfo: userInfo,
                                )));
                      },
                    ),
                    const SizedBox(height: 10),
                    primarySizedButton(
                      'Đổi mật khẩu',
                      context,
                      () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(
                                  userInfo: userInfo,
                                )));
                      },
                    ),
                    SizedBox(height: 10),
                  ],
          ),
        ),
      ),
    );
  }
}
