// ignore_for_file: avoid_print, avoid_init_to_null, prefer_const_constructors, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/employee/employee_screen.dart';
import 'package:rcore/views/products/products_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/drawer/navigation_drawer_widget.dart';
import '../map/map_screen.dart';
import '../profile/profile_screens.dart';
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
  // int index = 0;
  TextEditingController searchController = TextEditingController();
  int pageIndex = 1;
  int pageLimit = 78;
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
    // if (isLoadedData && !isLoadedAPI && searchController.text == '') {
    if (isLoadedData && searchController.text == '' && !isLoadedAPI) {
      await GetAPI(
          'https://anphat.andin.io/index.php?r=restful-api/get-list-khach-hang',
          context,
          'POST', {
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'].toString(),
        'limit': '78',
        // 'perPage': '4',
        'page': pageIndex.toString(),
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
      if (jsonData != null) pageLimit = jsonData!['so_trang'];
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
      pageLimit = jsonData!['so_trang'];
      List<dynamic> info = jsonData!['data'];
      infoPerPage = info.length;
    }
  }

  Widget twoTextBetween(IconData icon, Color iconColor, String value) {
    return Container(
      padding: const EdgeInsets.all(5),
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
          Icon(icon, color: iconColor, size: 15),
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
                fontSize: 15,
                color: iconColor,
              ),
            ),
          ),
        ],
      ),
    );
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
            color: buttonPrimaryColorActive,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            getFullCustomerInfo(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  twoTextBetween(Icons.person, Colors.black,
                      dataFormat(jsonData!['data'][index]['hoten'])),
                  twoTextBetween(Icons.phone, Colors.green,
                      dataFormat(jsonData!['data'][index]['dien_thoai'])),
                  twoTextBetween(Icons.home, themeColor,
                      dataFormat(jsonData!['data'][index]['dia_chi'])),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.delete),
              // )
              Column(
                children: [
                  SizedBox(
                      width: 115,
                      height: 45,
                      child: customSizedButton('Gọi điện', context, Icons.phone,
                          Colors.green, 10, () {})),
                  SizedBox(height: 5),
                  SizedBox(
                      width: 115,
                      height: 45,
                      child: customSizedButton('Nhắn tin', context,
                          Icons.message, Colors.blue, 10, () {})),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getFullCustomerInfo(int index) {
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
                'Thông tin khách hàng',
                style: TextStyle(
                  color: Colors.blue.shade200,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    dataToTextFieldWithLable(
                        'Email',
                        dataFormat(jsonData!['data'][index]['email']),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Phone',
                        dataFormat(jsonData!['data'][index]['dien_thoai']),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Address',
                        dataFormat(jsonData!['data'][index]['dia_chi']),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Nhu cầu quận',
                        dataFormat(jsonData!['data'][index]['nhu_cau_quan']),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Nhu cầu hướng',
                        dataFormat(jsonData!['data'][index]['nhu_cau_huong']),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Giá từ',
                        dataFormat(jsonData!['data'][index]['nhu_cau_gia_tu']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Giá đến',
                        dataFormat(jsonData!['data'][index]['nhu_cau_gia_den']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Khoảng giá',
                        dataFormat(
                            jsonData!['data'][index]['khoang_gia'].toString()),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Diện tích tối thiểu',
                        dataFormat(jsonData!['data'][index]
                                ['nhu_cau_dien_tich_tu']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Diện tích tối đa',
                        dataFormat(jsonData!['data'][index]
                                ['nhu_cau_dien_tich_den']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLable(
                        'Ghi chú',
                        dataFormat(jsonData!['data'][index]['ghi_chu']),
                        true,
                        context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 5),
                        SizedBox(
                          width: 90,
                          height: 45,
                          child: customSizedButton(
                              'Sửa', context, Icons.edit, Colors.green, 10, () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditCustomerScreen(
                                  jsonData: jsonData,
                                  index: index,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                            width: 90,
                            height: 45,
                            child: customSizedButton(
                                'Xóa', context, Icons.delete, Colors.red, 10,
                                () {
                              yesNoDialog('Thông báo',
                                  'Bạn có muốn xóa thông tin khách hàng không?',
                                  () {
                                GetAPI(
                                    'https://anphat.andin.io/index.php?r=restful-api/xoa-khach-hang',
                                    context,
                                    'POST', {
                                  'uid': userInfo!['id'].toString(),
                                  'auth': userInfo!['auth_key'].toString(),
                                  'id':
                                      jsonData!['data'][index]['id'].toString(),
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
                            })),
                        SizedBox(width: 5),
                        // IconButton(
                        //   padding: EdgeInsets.only(right: 40),
                        //   icon: Icon(
                        //     Icons.delete,
                        //     color: Colors.red,
                        //   ),
                        //   onPressed: () {},
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listPage = [
    CustomerScreen(),
    MapScreen(),
    ProfileScreen(),
    ProductsListScreen(),
    EmployeeListScreen(),
  ];

  //* If the string is null or empty, return the string 'null', otherwise return the string
  //*
  //* Args:
  //*   str (String): The string to be formatted.
  String dataFormat(String? str) => (str == null || str == '') ? '' : str;

  @override
  Widget build(BuildContext context) {
    getDataCustomer();

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Theme.of(context).backgroundColor,
        //   title: const Text(
        //     'Thông tin khách hàng',
        //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //   ),
        //   iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
        // ),
        drawer: NavigationDrawerWidget(
          listPage: listPage,
        ),

        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Thông tin khách hàng',
              style: TextStyle(color: Colors.black)),
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
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              hintText: 'Tìm kiếm khách hàng',
                              prefixIcon: Icon(
                                Icons.people_outlined,
                                color: themeColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  print('Search press');
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
                              filled: true,
                            ),
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
                          ((index) => getDemoUserInfo(index))),
                ),
              ),
              SizedBox(
                height: 60,
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
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
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
                          if (pageIndex < pageLimit) pageIndex++;
                          setState(() {});
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
