// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, avoid_init_to_null, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/ServicesController.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';
import '../../utils/dialogs/dialog.dart';

class EmployeeInfoScreen extends StatefulWidget {
  final Map<String, dynamic>? jsonData;
  const EmployeeInfoScreen({
    Key? key,
    this.jsonData,
  }) : super(key: key);

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  String dataFormat(String? str) => (str == null || str == '') ? '' : str;

  Widget getFullproductInfo() {
    return ListView(
      children: [
        dataToTextFieldWithLable(
            'ID nhân viên',
            dataFormat(widget.jsonData!['data']['id'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Username',
            dataFormat(widget.jsonData!['data']['username'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Email',
            dataFormat(widget.jsonData!['data']['email'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Điện thoại',
            dataFormat(widget.jsonData!['data']['dien_thoai'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Họ tên',
            dataFormat(widget.jsonData!['data']['hoten'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'CMND',
            dataFormat(widget.jsonData!['data']['cmnd'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Địa chỉ',
            dataFormat(widget.jsonData!['data']['dia_chi'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Ngày sinh',
            dataFormat(widget.jsonData!['data']['ngay_sinh'].toString()),
            true,
            context),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Thông tin chi tiết sản phẩm',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      body: getFullproductInfo(),
    );
  }
}
