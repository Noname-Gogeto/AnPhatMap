// ignore_for_file: avoid_print, avoid_init_to_null, prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/employee/employee_info_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  // final Map<String, dynamic>? userInfo;
  // const CustomerScreen({Key? key, this.userInfo}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  Map<String, dynamic>? jsonData = null;
  Map<String, dynamic>? jsonDetailsData = null;
  Map<String, dynamic>? userInfo = null;
  Map<String, dynamic>? productSearchList = null;
  bool isLoadedData = false;
  bool isLoadedAPI = false;
  int pageIndex = 1;
  int pageLimit = 32;
  int infoPerPage = 4;

  // TextEditingController dateFromController = TextEditingController();
  // TextEditingController dateToController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController idStaffInChargeController = TextEditingController();
  // TextEditingController idUpdateStaffController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  /// If the data is loaded and the API is not loaded, then load the API
  void getDataEmployee() async {
    try {
      if (!isLoadedData) {
        SharedPreferences.getInstance().then((prefs) => ({
              print("BEFORE: $userInfo"),
              print("DATA: ${prefs.getString('userInfo')}"),
              userInfo = jsonDecode(prefs.getString('userInfo')!),
              print("TEMP: $userInfo"),
              setState(() {
                isLoadedData = true;
              }),
            }));
      }
      if (isLoadedData && searchController.text == '' && !isLoadedAPI) {
        await GetAPI(
            'https://anphat.andin.io/index.php?r=restful-api/list-thanh-vien',
            context,
            'POST', {
          'uid': userInfo!['id'].toString(),
          'auth': userInfo!['auth_key'].toString(),
          // 'limit': '78',
          // 'perPage': '1',
        }).then(
          (Map<String, dynamic>? json) => ({
            if (json != null)
              {
                setState(() {
                  jsonData = json;
                  isLoadedAPI = true;
                })
              }
          }),
        );
        if (jsonData != null) {
          List<dynamic> info = jsonData!['data'];
          infoPerPage = info.length;
        }
      }
      if (searchController.text != '' && isLoadedAPI) {
        await GetAPI(
            'https://anphat.andin.io/index.php?r=restful-api/list-thanh-vien',
            context,
            'POST', {
          'uid': userInfo!['id'].toString(),
          'auth': userInfo!['auth_key'].toString(),
          'tuKhoa_VT': searchController.text,
          // 'trangThai': true,
        }).then(
          (Map<String, dynamic>? json) => ({
            if (json != null)
              {
                setState(() {
                  jsonData = json;
                  isLoadedAPI = false;
                })
              }
          }),
        );
        if (jsonData != null) {
          List<dynamic> info = jsonData!['data'];
          infoPerPage = info.length;
        }
      }
    } catch (e) {
      notiDialog(
          'Lỗi', e.toString(), () => Navigator.of(context).pop(), context);
    }
  }

  Widget textIconBetween(IconData icon, Color iconColor, String value,
      {bool? isValueBool = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 3),
      width: MediaQuery.of(context).size.width * 0.5,
      // decoration: const BoxDecoration(
      //     border: Border(bottom: BorderSide(color: Colors.grey))),
      // margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          // Text('$label:',
          //     style:
          //         const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Icon(
            icon,
            color: iconColor,
            size: 14,
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              // textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
              // maxLines: 2,
              // softWrap: false,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 14,
                color: iconColor,
                fontWeight:
                    (isValueBool == true) ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getEmployeeInfo(int index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(255, 244, 242, 242),
      // color: themeColor,
      child: Container(
        // padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: buttonPrimaryColorActive,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            // getFullProductInfo(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  textIconBetween(Icons.perm_identity, Colors.black,
                      dataFormat(jsonData!['data'][index]['id'].toString()),
                      isValueBool: true),
                  textIconBetween(Icons.person, Colors.black,
                      dataFormat(jsonData!['data'][index]['hoten'].toString()),
                      isValueBool: true),
                  textIconBetween(Icons.phone, Colors.green,
                      dataFormat(jsonData!['data'][index]['dien_thoai'])),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.delete),
              // )
              Column(
                children: [
                  // SizedBox(
                  //     width: 110,
                  //     height: 45,
                  //     child: customSizedButton('Chi tiết', context,
                  //         Icons.details_rounded, Colors.green, 10, () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => DetailsProductsListScreen(
                  //                 jsonData: jsonData,
                  //                 productIndex: index,
                  //               )));
                  //     })),
                  // SizedBox(height: 20),
                  SizedBox(
                      width: 110,
                      height: 45,
                      child: customSizedButton(
                          'Chi tiết', context, Icons.history, Colors.blue, 10,
                          () async {
                        await GetAPI(
                            'https://anphat.andin.io/index.php?r=restful-api/thong-tin-nhan-vien',
                            context,
                            'POST', {
                          'uid': userInfo!['id'].toString(),
                          'auth': userInfo!['auth_key'].toString(),
                          'id': jsonData!['data'][index]['id'].toString(),
                          // 'limit': '78',
                          // 'perPage': '1',
                        }).then(
                          (Map<String, dynamic>? json) => ({
                            if (json != null)
                              {
                                setState(() {
                                  jsonDetailsData = json;
                                  isLoadedAPI = true;
                                })
                              }
                          }),
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EmployeeInfoScreen(
                                  jsonData: jsonDetailsData,
                                )));
                      })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> employeeSearchList() {
    List<Widget> fullProductsList = List<Widget>.generate(
      jsonData!['content'].length,
      (index) => getEmployeeInfo(index),
    );
    if (searchController.text == '') {
      return fullProductsList;
    }

    final productIdListID = List<String>.generate(
      jsonData!['content'].length,
      (index) => jsonData!['content'][index]['id'].toString(),
    );
    List<Widget> searchProductList = [];
    for (var i = 0; i < jsonData!['content'].length; i++) {
      if (productIdListID[i].contains(searchController.text)) {
        searchProductList.add(getEmployeeInfo(i));
      }
    }
    return searchProductList;
  }

  void getFullEmployeeInfo(int index) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        child: Container(
          alignment: Alignment.center,

          // width: MediaQuery.of(context).size.width - 20,
          // height: MediaQuery.of(context).size.height - 20,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Text(
                'Lịch sử trạng thái',
                style: TextStyle(
                  color: Colors.blue.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      dataToTextFieldWithLable(
                          'ID',
                          dataFormat(jsonData!['data'][index]['id'].toString()),
                          true,
                          context),

                      dataToTextFieldWithLable(
                          'ID sản phẩm',
                          dataFormat(jsonData!['data'][index]['san_pham_id']
                              .toString()),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'Trạng thái sản phẩm',
                          dataFormat(jsonData!['data'][index]['trang_thai']),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'Thời gian thay đổi trạng thái',
                          dataFormat(
                              jsonData!['data'][index]['created'].toString()),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'ID người dùng tác động',
                          dataFormat(
                              jsonData!['data'][index]['user_id'].toString()),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'Ghi chú',
                          dataFormat(jsonData!['data'][index]['ghi_chu']),
                          true,
                          context),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(width: 5),
                      //     SizedBox(
                      //       width: 90,
                      //       height: 45,
                      //       child: customSizedButton(
                      //           'Sửa', context, Icons.edit, Colors.green, 10, () {
                      //         Navigator.of(context).pop();
                      //         Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (context) => EditCustomerScreen(
                      //               jsonData: jsonData,
                      //               index: index,
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      //     ),
                      //     SizedBox(
                      //         width: 90,
                      //         height: 45,
                      //         child: customSizedButton(
                      //             'Xóa', context, Icons.delete, Colors.red, 10,
                      //             () {
                      //           yesNoDialog('Thông báo',
                      //               'Bạn có muốn xóa thông tin khách hàng không?',
                      //               () {
                      //             GetAPI(
                      //                 'https://anphat.andin.io/index.php?r=restful-api/xoa-khach-hang',
                      //                 context,
                      //                 'POST', {
                      //               'uid': userInfo!['id'].toString(),
                      //               'auth': userInfo!['auth_key'].toString(),
                      //               'id':
                      //                   jsonData!['data'][index]['id'].toString(),
                      //             }).then((Map<String, dynamic>? json) => ({
                      //                   if (json != null)
                      //                     {
                      //                       notiDialog(
                      //                           'Thông báo', json['message'],
                      //                           () async {
                      //                         var prefs = await SharedPreferences
                      //                             .getInstance();
                      //                         await prefs.setString('userInfo',
                      //                             jsonEncode(json['data']));
                      //                         Navigator.of(context).pop();
                      //                         Navigator.of(context).pop();
                      //                       }, context)
                      //                     }
                      //                 }));
                      //           }, () => Navigator.of(context).pop(), context);
                      //         })),
                      //     SizedBox(width: 5),
                      //     // IconButton(
                      //     //   padding: EdgeInsets.only(right: 40),
                      //     //   icon: Icon(
                      //     //     Icons.delete,
                      //     //     color: Colors.red,
                      //     //   ),
                      //     //   onPressed: () {},
                      //     // )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// If the string is null or empty, return the string 'null', otherwise return the string
  ///
  /// Args:
  ///   str (String): The string to be formatted.
  String dataFormat(String? str) =>
      (str == null || str == '' || str == 'null') ? '' : str;

  // @override
  // void initState() {}

  @override
  Widget build(BuildContext context) {
    getDataEmployee();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Thông tin nhân viên',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 242, 242),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 244, 242, 242),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Theme(
                        data: Theme.of(context)
                            .copyWith(primaryColor: themeColor),
                        child: TextField(
                            onChanged: (value) {
                              // if (dateFromController.text == '' &&
                              //     dateToController.text == '' &&
                              //     addressController.text == '' &&
                              //     idStaffInChargeController.text == '' &&
                              //     idUpdateStaffController.text == '' &&
                              //     searchController.text == '') {
                              //   isLoadedAPI = false;
                              // }
                              setState(() {});
                            },
                            controller: searchController,
                            cursorColor: componentPrimaryColor,
                            enableSuggestions: true,
                            autocorrect: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                hintText: 'Tìm kiếm nhân viên',
                                prefixIcon: Icon(
                                  Icons.production_quantity_limits_rounded,
                                  color: themeColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    print('Filter press');
                                    // searchFilterOptions();
                                    setState(() {});
                                  },
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                fillColor: Color.fromRGBO(250, 250, 250, 1),
                                filled: true),
                            style: TextStyle(
                              color: Colors.black,
                            )))
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children:
                      jsonData == null // hiển thị dữ liệu duới dạng listview
                          ? []
                          : List<Widget>.generate(
                              infoPerPage,
                              (index) => getEmployeeInfo(index),
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
