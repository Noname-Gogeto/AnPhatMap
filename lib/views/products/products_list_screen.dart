// ignore_for_file: avoid_print, avoid_init_to_null, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/products/details_products_list_screen.dart';
import 'package:rcore/views/products/products_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/ServicesController.dart';

import '../../utils/color/theme.dart';
import '../../utils/drawer/navigation_drawer_widget.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Map<String, dynamic>? jsonData = null;
  Map<String, dynamic>? jsonDataState = null;
  Map<String, dynamic>? userInfo = null;
  Map<String, dynamic>? productSearchList = null;
  bool isLoadedData = false;
  bool isLoadedAPI = false;
  int pageIndex = 1;
  int itemPageLimit = 32;
  int infoPerPage = 8;

  // TextEditingController dateFromController = TextEditingController();
  // TextEditingController dateToController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController idStaffInChargeController = TextEditingController();
  // TextEditingController idUpdateStaffController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  /// If the data is loaded and the API is not loaded, then load the API
  void getDataProduct() {
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
        GetAPI(
            'https://anphat.andin.io/index.php?r=restful-api/get-data-san-pham',
            context,
            'POST', {
          'uid': userInfo!['id'].toString(),
          'auth': userInfo!['auth_key'].toString(),
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
      }
      // isLoadedData ||
      //     dateFromController.text != '' ||
      //     dateToController.text != '' ||
      //     addressController.text != '' ||
      //     idStaffInChargeController.text != '' ||
      if (searchController.text != '') {
        GetAPI(
            'https://anphat.andin.io/index.php?r=restful-api/get-data-san-pham',
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
      width: MediaQuery.of(context).size.width - (60 + 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 3),
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

  Widget getDemoProductInfo(int index) {
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsProductsListScreen(
                  jsonData: jsonData,
                  productIndex: index,
                  userInfo: userInfo,
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 5, bottom: 3),
                    width: MediaQuery.of(context).size.width - (60 + 60),
                    child: Text(
                        dataFormat(jsonData!['content'][index]['ngay_tao']),
                        style: TextStyle(color: Colors.grey)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 3),
                    width: MediaQuery.of(context).size.width - (60 + 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person, color: themeColor),
                        SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            '${jsonData!['content'][index]['chu_nha']}',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 14,
                              color: themeColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        SizedBox(
                          width: 5,
                          child: Text(
                            '-',
                            style: TextStyle(color: themeColor),
                          ),
                        ),
                        Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            '${dataFormat(jsonData!['content'][index]['dien_thoai'])}',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 14,
                              color: themeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // textIconBetween(Icons.person, themeColor,
                  //     dataFormat(jsonData!['content'][index]['chu_nha'])),
                  // textIconBetween(
                  //     Icons.phone,
                  //     Colors.green,
                  //     dataFormat(jsonData!['content'][index]['dien_thoai']
                  //         .toString())),
                  textIconBetween(
                      Icons.attach_money,
                      Colors.black,
                      dataFormat(NumberFormat()
                          .format(double.parse(
                              jsonData!['content'][index]['gia_tu']))
                          .toString()),
                      isValueBool: true),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateProductScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.sell_rounded,
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> productsSearchList() {
    List<Widget> fullProductsList = List<Widget>.generate(
      jsonData!['content'].length,
      (index) => getDemoProductInfo(index),
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
        searchProductList.add(getDemoProductInfo(i));
      }
    }
    return searchProductList;
  }

  /// If the string is null or empty, return the string 'null', otherwise return the string
  ///
  /// Args:
  ///   str (String): The string to be formatted.
  String dataFormat(String? str) =>
      (str == null || str == '' || str == 'null') ? '' : str;

  @override
  Widget build(BuildContext context) {
    getDataProduct();
    // pageLimit = jsonData != null ? jsonData!['so_trang'] : 1;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Thông tin sản phẩm',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
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
                                hintText: 'Tìm kiếm sản phẩm',
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
                              (index) {
                                for (var pageItemIndex =
                                        (pageIndex - 1) * infoPerPage + index;
                                    pageItemIndex < infoPerPage * pageIndex &&
                                        pageItemIndex < itemPageLimit;
                                    pageItemIndex++) {
                                  return getDemoProductInfo(pageItemIndex);
                                }
                                return Container();
                              },
                            ),
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
                          if (pageIndex < itemPageLimit / infoPerPage) {
                            pageIndex++;
                          }
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
