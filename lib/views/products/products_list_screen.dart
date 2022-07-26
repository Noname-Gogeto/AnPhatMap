// ignore_for_file: avoid_print, avoid_init_to_null, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/views/products/details_products_list_screen.dart';
import 'package:rcore/views/products/products_screen.dart';
import 'package:rcore/views/products/sell_products_screen.dart';
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

  //* Default page info change when API loaded
  int pageIndex = 1;
  int pageMaxSize = 31;
  int infoPerPage = 32;

  // TextEditingController dateFromController = TextEditingController();
  // TextEditingController dateToController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController idStaffInChargeController = TextEditingController();
  // TextEditingController idUpdateStaffController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  /// If the data is loaded and the API is not loaded, then load the API
  Future<void> getDataProduct() async {
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
          'https://anphat.andin.io/index.php?r=restful-api/get-data-san-pham',
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
              })
            }
        }),
      );
    }
    if (searchController.text != '' && isLoadedData) {
      await GetAPI(
          'https://anphat.andin.io/index.php?r=restful-api/get-data-san-pham',
          context,
          'POST', {
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'].toString(),
        'tuKhoa_VT': searchController.text,
        'page': pageIndex.toString(),
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
    if (jsonData != null) {
      pageMaxSize = jsonData!['sotrang'];
      List<dynamic> info = jsonData!['content'];
      infoPerPage = info.length;
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
          Icon(
            icon,
            color: iconColor,
            size: 25,
          ),
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
                fontSize: 13,
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
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(255, 244, 242, 242),
      // color: themeColor,
      child: Container(
        // padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            // color: buttonPrimaryColorActive,
            color: Colors.transparent,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
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
                    padding: const EdgeInsets.only(
                        left: 10, right: 5, top: 5, bottom: 3),
                    width: MediaQuery.of(context).size.width - (60 + 60),
                    child: Text(
                        dataFormat(jsonData!['content'][index]['ngay_tao']),
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 3),
                    width: MediaQuery.of(context).size.width - (60 + 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          color: themeColor,
                          size: 25,
                        ),
                        SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            '${jsonData!['content'][index]['chu_nha']}',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 13,
                              color: themeColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        dataFormat(jsonData!['content'][index]
                                    ['dien_thoai_chu_nha']) !=
                                ''
                            ? (SizedBox(
                                width: 5,
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: themeColor, fontSize: 13),
                                ),
                              ))
                            : SizedBox(height: 0, width: 0),
                        dataFormat(jsonData!['content'][index]
                                    ['dien_thoai_chu_nha']) !=
                                ''
                            ? (Icon(
                                Icons.phone,
                                color: Colors.green,
                                size: 25,
                              ))
                            : SizedBox(height: 0, width: 0),
                        SizedBox(width: 3),
                        dataFormat(jsonData!['content'][index]
                                    ['dien_thoai_chu_nha']) !=
                                ''
                            ? (Flexible(
                                child: Text(
                                  '${dataFormat(jsonData!['content'][index]['dien_thoai_chu_nha'])}',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: themeColor,
                                  ),
                                ),
                              ))
                            : SizedBox(height: 0, width: 0),
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
                          // builder: (context) => CreateProductScreen(
                          //   jsonData: jsonData,
                          //   productIndex: index,
                          //   userInfo: userInfo,
                          // ),
                          builder: (context) => SellProductScreen(
                            jsonData: jsonData,
                            productIndex: index,
                            userInfo: userInfo,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.sell_rounded,
                      color: themeColor,
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
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              'Thông tin sản phẩm',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
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
          // backgroundColor: const Color.fromARGB(255, 244, 242, 242),
          backgroundColor: backgroundColor,

          body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            color: backgroundColor,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: backgroundColor,
                  child: Column(
                    children: [
                      TextField(
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
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: 'Tìm kiếm sản phẩm',
                            hintStyle: TextStyle(fontSize: 16),
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: themeColor,
                              ),
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
                            fillColor: Color.fromRGBO(240, 240, 240, 1),
                            filled: true),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
                                // (index) {
                                //   for (var pageItemIndex =
                                //           (pageIndex - 1) * infoPerPage + index;
                                //       pageItemIndex < infoPerPage * pageIndex &&
                                //           pageItemIndex < pageMaxSize;
                                //       pageItemIndex++) {
                                //     return getDemoProductInfo(pageItemIndex);
                                //   }
                                //   return Container();
                                // },
                                (index) => getDemoProductInfo(index),
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
                          isLoadedAPI = false;
                          if (pageIndex > 1) pageIndex--;
                          setState(() {});
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                        color: (pageIndex > 1) ? textColor : Colors.transparent,
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
                          isLoadedAPI = false;
                          if (pageIndex < pageMaxSize) {
                            pageIndex++;
                          }
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
