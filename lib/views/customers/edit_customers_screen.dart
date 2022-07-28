// ignore_for_file: public_member_api_docs, sort_constructors_first, must_call_super
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/landing/login_screen.dart';

class EditCustomerScreen extends StatefulWidget {
  final int? uid;
  final String? auth;
  final Map<String, dynamic>? jsonData;
  final int? index;
  const EditCustomerScreen({
    Key? key,
    this.uid,
    this.auth,
    this.jsonData,
    this.index,
  }) : super(key: key);

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreen();
}

class _EditCustomerScreen extends State<EditCustomerScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController districDemandController = TextEditingController();
  // TextEditingController directionDemandController = TextEditingController();
  // TextEditingController priceFromController = TextEditingController();
  // TextEditingController priceToController = TextEditingController();
  // TextEditingController priceRangeController = TextEditingController();
  // TextEditingController minimumAreaController = TextEditingController();
  // TextEditingController maximumAreaController = TextEditingController();
  // TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    idController.text = '';
    fullNameController.text = '';
    emailController.text = '';
    phoneNumberController.text = '';
    birthdayController.text = '';
    addressController.text = '';
  }

  String dataFormat(String? str, String showStr) =>
      (str == null || str == '') ? showStr : str;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Chỉnh sửa thông tin khách hàng',
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
                  SizedBox(height: 30),
                  textFieldWithPrefixIcon(
                      dataFormat(
                          widget.jsonData!['data'][widget.index]['hoten'],
                          'Họ tên'),
                      Icons.person,
                      'text',
                      fullNameController,
                      context),
                  textFieldWithPrefixIcon(
                      dataFormat(
                          widget.jsonData!['data'][widget.index]['email'],
                          'Email'),
                      Icons.email,
                      'text',
                      emailController,
                      context),
                  textFieldWithPrefixIcon(
                      dataFormat(
                          widget.jsonData!['data'][widget.index]['dien_thoai'],
                          'Số điện thoại'),
                      Icons.phone,
                      'text',
                      phoneNumberController,
                      context),
                  textFieldWithPrefixIcon(
                      'Ngày sinh',
                      Icons.date_range_outlined,
                      'date',
                      birthdayController,
                      context),
                  textFieldWithPrefixIcon(
                      dataFormat(
                          widget.jsonData!['data'][widget.index]['dia_chi'],
                          'Địa chỉ'),
                      Icons.home_rounded,
                      'text',
                      addressController,
                      context),
                  // textFieldWithPrefixIcon(
                  //     'Nhu cầu quận',
                  //     Icons.holiday_village_rounded,
                  //     'text',
                  //     districDemandController,
                  //     context),
                  // textFieldWithPrefixIcon('Nhu cầu hướng', Icons.directions,
                  //     'text', directionDemandController, context),
                  // textFieldWithPrefixIcon('Giá từ', Icons.price_change, 'text',
                  //     priceFromController, context),
                  // textFieldWithPrefixIcon(
                  //     'Giá đến',
                  //     Icons.price_change_outlined,
                  //     'text',
                  //     priceToController,
                  //     context),
                  // textFieldWithPrefixIcon(
                  //     'Khoảng giá',
                  //     Icons.price_check_rounded,
                  //     'text',
                  //     priceRangeController,
                  //     context),
                  // textFieldWithPrefixIcon('Diện tích tối thiểu',
                  //     Icons.area_chart, 'text', minimumAreaController, context),
                  // textFieldWithPrefixIcon(
                  //     'Diện tích tối đa',
                  //     Icons.area_chart_outlined,
                  //     'text',
                  //     maximumAreaController,
                  //     context),
                  // textFieldWithPrefixIcon('Ghi chú', Icons.note_add_rounded,
                  //     'text', noteController, context),

                  primarySizedButton(
                    'Cập nhật',
                    context,
                    () {
                      GetAPI(
                          'https://anphat.andin.io/index.php?r=restful-api/edit-khach-hang',
                          context,
                          'POST', {
                        'uid': widget.uid,
                        'auth': widget.auth,
                        'id': widget.jsonData!['data'][widget.index]['id'],
                        'hoTen': fullNameController.text,
                        'dienThoai': phoneNumberController.text,
                        'email': emailController.text,
                        'ngay_sinh': birthdayController.text,
                        'dia_chi': addressController.text,
                      }).then((Map<String, dynamic>? json) => ({
                            if (json != null)
                              {
                                notiDialog('Thông báo', json['message'],
                                    () async {
                                  var prefs =
                                      await SharedPreferences.getInstance();
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
