// ignore_for_file: public_member_api_docs, sort_constructors_first, must_call_super
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/landing/login_screen.dart';

import '../../utils/buttons/text_button.dart';

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
    fullNameController.text =
        dataFormat(widget.jsonData!['data'][widget.index]['hoten']);
    emailController.text =
        dataFormat(widget.jsonData!['data'][widget.index]['email']);
    phoneNumberController.text =
        dataFormat(widget.jsonData!['data'][widget.index]['dien_thoai']);
    birthdayController.text = '';
    addressController.text =
        dataFormat(widget.jsonData!['data'][widget.index]['dia_chi']);
  }

  // String dataFormat(String? str, String showStr) =>
  //     (str == null || str == '' || str == 'null') ? showStr : str;

  String dataFormat(String? str) =>
      (str == null || str == '' || str == 'null') ? '' : str;

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
                  SizedBox(height: 0),
                  // textFieldWithPrefixIcon(
                  //     dataFormat(
                  //         widget.widget.jsonData!['data'][widget.index]['hoten'],
                  //        'Họ tên'),
                  //     Icons.person,
                  //     'text',
                  //     fullNameController,
                  //     context),
                  // textFieldWithPrefixIcon(
                  //     dataFormat(
                  //         widget.widget.jsonData!['data'][widget.index]['email'],
                  //         'Email'),
                  //     Icons.email,
                  //     'text',
                  //     emailController,
                  //     context),
                  // textFieldWithPrefixIcon(
                  //     dataFormat(
                  //         widget.widget.jsonData!['data'][widget.index]['dien_thoai'],
                  //         'Số điện thoại'),
                  //     Icons.phone,
                  //     'text',
                  //     phoneNumberController,
                  //     context),
                  // textFieldWithPrefixIcon(
                  //     'Ngày sinh',
                  //     Icons.date_range_outlined,
                  //     'date',
                  //     birthdayController,
                  //     context),
                  // textFieldWithPrefixIcon(
                  //     dataFormat(
                  //         widget.widget.jsonData!['data'][widget.index]['dia_chi'],
                  //         'Địa chỉ'),
                  //     Icons.home_rounded,
                  //     'text',
                  //     addressController,
                  //     context),
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

                  dataToTextFieldWithLable2(
                    'Họ tên',
                    dataFormat(widget.jsonData!['data'][widget.index]['hoten']),
                    false,
                    context,
                    textController: fullNameController,
                  ),
                  dataToTextFieldWithLable2(
                    'Phone',
                    dataFormat(
                        widget.jsonData!['data'][widget.index]['dien_thoai']),
                    false,
                    context,
                    textController: phoneNumberController,
                  ),
                  dataToTextFieldWithLable2(
                    'Email',
                    dataFormat(widget.jsonData!['data'][widget.index]['email']),
                    false,
                    context,
                    textController: emailController,
                  ),
                  dataToTextFieldWithLable2(
                    'Ngày sinh',
                    birthdayController.text,
                    false,
                    context,
                    inputType: 'date',
                    textController: birthdayController,
                  ),
                  dataToTextFieldWithLable2(
                    'Address',
                    dataFormat(
                        widget.jsonData!['data'][widget.index]['dia_chi']),
                    false,
                    context,
                    textController: addressController,
                  ),
                  // dataToTextFieldWithLable2(
                  //     'Nhu cầu quận',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //         ['nhu_cau_quan']),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Nhu cầu hướng',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //         ['nhu_cau_huong']),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Nhu cầu giá từ',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //             ['nhu_cau_gia_tu']
                  //         .toString()),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Nhu cầu giá đến',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //             ['nhu_cau_gia_den']
                  //         .toString()),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Khoảng giá',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //             ['khoang_gia']
                  //         .toString()),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Diện tích tối thiểu',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //             ['nhu_cau_dien_tich_tu']
                  //         .toString()),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Diện tích tối đa',
                  //     dataFormat(widget.jsonData!['data'][widget.index]
                  //             ['nhu_cau_dien_tich_den']
                  //         .toString()),
                  //     true,
                  //     context),
                  // dataToTextFieldWithLable2(
                  //     'Ghi chú',
                  //     dataFormat(
                  //         widget.jsonData!['data'][widget.index]['ghi_chu']),
                  //     true,
                  //     context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SizedBox(width: 5),
                        SizedBox(
                          // padding: EdgeInsets.only(left: 5),
                          // alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width -
                              (20 + 40 + 10),
                          height: 40,
                          child: customSizedButton(
                            'Sửa',
                            context,
                            Icons.edit,
                            Colors.green,
                            10,
                            () {
                              GetAPI(
                                  'https://anphat.andin.io/index.php?r=restful-api/edit-khach-hang',
                                  context,
                                  'POST', {
                                'uid': widget.uid.toString(),
                                'auth': widget.auth,
                                'id': widget.jsonData!['data'][widget.index]
                                        ['id']
                                    .toString(),
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
                                          var prefs = await SharedPreferences
                                              .getInstance();
                                          await prefs.setString('userInfo',
                                              jsonEncode(json['data']));
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }, context)
                                      }
                                  }));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              yesNoDialog('Thông báo',
                                  'Bạn có muốn xóa thông tin khách hàng không?',
                                  () {
                                GetAPI(
                                    'https://anphat.andin.io/index.php?r=restful-api/xoa-khach-hang',
                                    context,
                                    'POST', {
                                  'uid': widget.uid.toString(),
                                  'auth': widget.auth,
                                  'id': widget.jsonData!['data'][widget.index]
                                          ['id']
                                      .toString(),
                                }).then((Map<String, dynamic>? json) => ({
                                      if (json != null)
                                        {
                                          notiDialog(
                                              'Thông báo', json['message'],
                                              () async {
                                            var prefs = await SharedPreferences
                                                .getInstance();
                                            await prefs.setString('userInfo',
                                                jsonEncode(json['data']));
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          }, context)
                                        }
                                    }));
                              }, () => Navigator.of(context).pop(), context);
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.all(8.5)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  buttonPrimaryColorText),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(color: Colors.red))),
                            ),
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
