// ignore_for_file: avoid_print, avoid_init_to_null, prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/drawer/navigation_drawer_widget.dart';

import '../../utils/text_input/text_input.dart';
import 'edit_customers_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  // final Map<String, dynamic>? userInfo;
  // const CustomerScreen({Key? key, this.userInfo}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Map<String, dynamic>? jsonData = null;
  Map<String, dynamic>? userInfo = null;
  bool isLoadedData = false;
  bool isLoadedAPI = false;
  bool isDataUpdate = false;
  // int index = 0;
  TextEditingController searchController = TextEditingController();

  //* Default page info change when API loaded
  int pageIndex = 1;
  int pageMaxSize = 78;
  int infoPerPage = 20;

  /// If the data is loaded and the API is not loaded, then load the API
  void getDataCustomer() async {
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
    if (isLoadedData &&
        searchController.text == '' &&
        (!isLoadedAPI || isDataUpdate)) {
      await GetAPI(
          'https://anphat.andin.io/index.php?r=restful-api/get-list-khach-hang',
          context,
          'POST', {
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'].toString(),
        'page': pageIndex.toString(),
      }).then(
        (Map<String, dynamic>? json) => ({
          if (json != null)
            {
              setState(() {
                jsonData = json;
                isLoadedAPI = true;
                isDataUpdate = false;
              })
            }
        }),
      );
    }
    if (searchController.text != '' && isLoadedData) {
      await GetAPI(
          'https://anphat.andin.io/index.php?r=restful-api/get-list-khach-hang',
          context,
          'POST', {
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'].toString(),
        'tuKhoa': searchController.text,
        'page': pageIndex.toString(),
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
    }
    if (jsonData != null) {
      pageMaxSize = jsonData!['so_trang'];
      List<dynamic> info = jsonData!['data'];
      infoPerPage = info.length;
    }
  }

  Widget getDemoUserInfo(int index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(255, 244, 242, 242),
      // color: themeColor,
      child: Container(
        // padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          // onPressed: () {
          //   getFullCustomerInfo(index);
          // },
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditCustomerScreen(
                  userInfo: userInfo,
                  jsonData: jsonData,
                  index: index,
                ),
              ),
            );
            // isLoadedData = false;
            // isLoadedAPI = false;
            isDataUpdate = true;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  textIconBetween(Icons.person, Colors.black,
                      dataFormat(jsonData!['data'][index]['hoten']), context),
                  textIconBetween(
                      Icons.phone,
                      Colors.green,
                      dataFormat(jsonData!['data'][index]['dien_thoai']),
                      context),
                  textIconBetween(Icons.home, themeColor,
                      dataFormat(jsonData!['data'][index]['dia_chi']), context),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.delete),
              // )
              Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(
                        Icons.message,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // void getFullCustomerInfo(int index) {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (context) => StatefulBuilder(builder: (context, setState) {
  //       return Dialog(
  //         child: Container(
  //           alignment: Alignment.center,
  //           width: MediaQuery.of(context).size.width - 20,
  //           height: MediaQuery.of(context).size.height * 0.9,
  //           padding: const EdgeInsets.all(10),
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(30),
  //             ),
  //           ),
  //           child: Column(
  //             children: [
  //               Text(
  //                 'Thông tin khách hàng',
  //                 style: TextStyle(
  //                   color: textColor,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 22,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               SizedBox(height: 10),
  //               Expanded(
  //                 child: ListView(
  //                   // mainAxisAlignment: MainAxisAlignment.center,
  //                   // crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     dataToTextFieldWithLableInDialog(
  //                         'Email',
  //                         dataFormat(jsonData!['data'][index]['email']),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Phone',
  //                         dataFormat(jsonData!['data'][index]['dien_thoai']),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Address',
  //                         dataFormat(jsonData!['data'][index]['dia_chi']),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Nhu cầu quận',
  //                         dataFormat(jsonData!['data'][index]['nhu_cau_quan']),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Nhu cầu hướng',
  //                         dataFormat(jsonData!['data'][index]['nhu_cau_huong']),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Nhu cầu giá từ',
  //                         dataFormat(jsonData!['data'][index]['nhu_cau_gia_tu']
  //                             .toString()),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Nhu cầu giá đến',
  //                         dataFormat(jsonData!['data'][index]['nhu_cau_gia_den']
  //                             .toString()),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Khoảng giá',
  //                         dataFormat(jsonData!['data'][index]['khoang_gia']
  //                             .toString()),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Diện tích tối thiểu',
  //                         dataFormat(jsonData!['data'][index]
  //                                 ['nhu_cau_dien_tich_tu']
  //                             .toString()),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Diện tích tối đa',
  //                         dataFormat(jsonData!['data'][index]
  //                                 ['nhu_cau_dien_tich_den']
  //                             .toString()),
  //                         true,
  //                         context),
  //                     dataToTextFieldWithLableInDialog(
  //                         'Ghi chú',
  //                         dataFormat(jsonData!['data'][index]['ghi_chu']),
  //                         true,
  //                         context),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width - 100,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           // SizedBox(width: 5),
  //                           SizedBox(
  //                             // padding: EdgeInsets.only(left: 5),
  //                             // alignment: Alignment.centerLeft,
  //                             width: MediaQuery.of(context).size.width -
  //                                 (100 + 40 + 10),
  //                             height: 40,
  //                             child: customSizedButton(
  //                               'Sửa',
  //                               context,
  //                               Icons.edit,
  //                               Colors.green,
  //                               10,
  //                               () {
  //                                 Navigator.of(context).pop();
  //                                 Navigator.of(context).push(
  //                                   MaterialPageRoute(
  //                                     builder: (context) => EditCustomerScreen(
  //                                       uid: userInfo!['id'],
  //                                       auth: userInfo!['auth_key'].toString(),
  //                                       jsonData: jsonData,
  //                                       index: index,
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: 40,
  //                             height: 40,
  //                             child: ElevatedButton(
  //                               onPressed: () {
  //                                 yesNoDialog('Thông báo',
  //                                     'Bạn có muốn xóa thông tin khách hàng không?',
  //                                     () {
  //                                   GetAPI(
  //                                       'https://anphat.andin.io/index.php?r=restful-api/xoa-khach-hang',
  //                                       context,
  //                                       'POST', {
  //                                     'uid': userInfo!['id'].toString(),
  //                                     'auth': userInfo!['auth_key'].toString(),
  //                                     'id': jsonData!['data'][index]['id']
  //                                         .toString(),
  //                                   }).then((Map<String, dynamic>? json) => ({
  //                                         if (json != null)
  //                                           {
  //                                             notiDialog(
  //                                                 'Thông báo', json['message'],
  //                                                 () async {
  //                                               var prefs =
  //                                                   await SharedPreferences
  //                                                       .getInstance();
  //                                               await prefs.setString(
  //                                                   'userInfo',
  //                                                   jsonEncode(json['data']));
  //                                               Navigator.of(context).pop();
  //                                               Navigator.of(context).pop();
  //                                             }, context)
  //                                           }
  //                                       }));
  //                                 }, () => Navigator.of(context).pop(),
  //                                     context);
  //                               },
  //                               style: ButtonStyle(
  //                                 padding: MaterialStateProperty.all<
  //                                     EdgeInsetsGeometry>(EdgeInsets.all(8.5)),
  //                                 foregroundColor:
  //                                     MaterialStateProperty.all<Color>(
  //                                         buttonPrimaryColorText),
  //                                 backgroundColor:
  //                                     MaterialStateProperty.all<Color>(
  //                                         Colors.red),
  //                                 shape: MaterialStateProperty.all<
  //                                         RoundedRectangleBorder>(
  //                                     RoundedRectangleBorder(
  //                                         borderRadius:
  //                                             BorderRadius.circular(10),
  //                                         side: BorderSide(color: Colors.red))),
  //                               ),
  //                               child: Icon(Icons.delete),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     }),
  //   );
  // }

  //* If the string is null or empty, return the string 'null', otherwise return the string
  //*
  //* Args:
  //*   str (String): The string to be formatted.
  String dataFormat(String? str) =>
      (str == null || str == '' || str == 'null') ? '' : str;

  @override
  Widget build(BuildContext context) {
    getDataCustomer();

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Thông tin khách hàng',
                style: TextStyle(color: Colors.black, fontSize: 20)),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black, // <-- SEE HERE
            ),
            leading: Container(
                padding: EdgeInsets.all(6),
                child: Image.asset('lib/assets/images/main-logo.png')),
            actions: [
              IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.list))
            ],
          ),
          drawer: NavigationDrawerWidget(userInfo: userInfo),
          backgroundColor: backgroundColor,
          body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            color: backgroundColor,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: backgroundColor,
                  child: TextField(
                    onChanged: (value) {
                      pageIndex = 1;
                      setState(() {});
                    },
                    controller: searchController,
                    cursorColor: componentPrimaryColor,
                    enableSuggestions: true,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: 'Tìm kiếm khách hàng',
                      hintStyle: TextStyle(fontSize: 16),
                      prefixIcon: Icon(
                        Icons.search,
                        color: themeColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      fillColor: Color.fromRGBO(240, 240, 240, 1),
                      filled: true,
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Column(
                  // scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  children: jsonData ==
                          null // hiển thị dữ liệu duới dạng listview
                      ? []
                      : List<Widget>.generate(
                          infoPerPage,
                          // (index) {
                          //   for (var pageItemIndex =
                          //           (pageIndex - 1) * infoPerPage + index;
                          //       pageItemIndex < infoPerPage * pageIndex &&
                          //           pageItemIndex < pageLimit;
                          //       pageItemIndex++) {
                          //     return getDemoUserInfo(pageItemIndex);
                          //   }
                          //   return Container();
                          // },
                          (index) => getDemoUserInfo(index)),
                ),
                SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          isLoadedAPI = false;
                          if (pageIndex > 1) pageIndex--;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color:
                              (pageIndex > 1) ? textColor : Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: buttonPrimaryColorActive,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Text('$pageIndex'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // if (pageIndex < pageLimit / infoPerPage) pageIndex++;
                          isLoadedAPI = false;
                          if (pageIndex < pageMaxSize) pageIndex++;
                          setState(() {});
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        color: (pageIndex < pageMaxSize)
                            ? textColor
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
