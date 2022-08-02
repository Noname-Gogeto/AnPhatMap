// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, avoid_init_to_null, avoid_print

import 'package:flutter/material.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';

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
  String dataFormat(String? str) =>
      (str == null || str == '' || str == 'null') ? '' : str;

  Widget getFullproductInfo() {
    return ListView(
      children: [
        SizedBox(height: 20),
        dataToTextFieldWithLable2(
            'ID nhân viên',
            dataFormat(widget.jsonData!['data']['id'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Username',
            dataFormat(widget.jsonData!['data']['username'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Email',
            dataFormat(widget.jsonData!['data']['email'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Điện thoại',
            dataFormat(widget.jsonData!['data']['dien_thoai'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Họ tên',
            dataFormat(widget.jsonData!['data']['hoten'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'CMND',
            dataFormat(widget.jsonData!['data']['cmnd'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Địa chỉ',
            dataFormat(widget.jsonData!['data']['dia_chi'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Ngày sinh',
            dataFormat(widget.jsonData!['data']['ngay_sinh'].toString()),
            true,
            context,
            highContrast: true),
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
          'Thông tin chi tiết nhân viên',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
      ),
      backgroundColor: backgroundColor,
      body: getFullproductInfo(),
    );
  }
}
