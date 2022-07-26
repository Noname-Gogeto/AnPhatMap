// ignore_for_file: avoid_print, avoid_init_to_null, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import 'package:rcore/views/products/details_products_list_screen.dart';
import 'package:rcore/views/products/sell_products_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  // final Map<String, dynamic>? userInfo;
  // const CustomerScreen({Key? key, this.userInfo}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  Map<String, dynamic>? jsonData = null;
  Map<String, dynamic>? jsonDataState = null;
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
          Icon(icon, color: iconColor),
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
                fontSize: 16,
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsProductsListScreen(
                      jsonData: jsonData,
                      productIndex: index,
                    )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  textIconBetween(
                      Icons.production_quantity_limits_rounded,
                      Colors.black,
                      dataFormat(jsonData!['content'][index]['id'].toString()),
                      isValueBool: true),
                  textIconBetween(
                      Icons.attach_money,
                      Colors.black,
                      dataFormat(NumberFormat()
                          .format(double.parse(
                              jsonData!['content'][index]['gia_tu']))
                          .toString()),
                      isValueBool: true),
                  textIconBetween(Icons.person, themeColor,
                      dataFormat(jsonData!['content'][index]['chu_nha'])),
                  textIconBetween(
                      Icons.phone,
                      Colors.green,
                      dataFormat(jsonData!['content'][index]['dien_thoai']
                          .toString())),
                  textIconBetween(Icons.date_range_rounded, themeColor,
                      dataFormat(jsonData!['content'][index]['ngay_tao'])),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.delete),
              // )
              Column(
                children: [
                  SizedBox(
                      width: 110,
                      height: 45,
                      child: customSizedButton(
                          'Bán', context, Icons.sell_rounded, Colors.green, 10,
                          () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SellProductScreen(
                                  jsonData: jsonData,
                                  productIndex: index,
                                  userInfo: userInfo,
                                )));
                      })),
                  SizedBox(height: 20),
                  SizedBox(
                      width: 110,
                      height: 45,
                      child: customSizedButton(
                          'Lịch sử', context, Icons.history, Colors.red, 10,
                          () async {
                        await GetAPI(
                            'https://anphat.andin.io/index.php?r=restful-api/get-lich-su-trang-thai',
                            context,
                            'POST', {
                          'uid': userInfo!['id'].toString(),
                          'auth': userInfo!['auth_key'].toString(),
                          'id': jsonData!['content'][index]['id'].toString(),
                        }).then(
                          (Map<String, dynamic>? json) => ({
                            if (json != null)
                              {
                                setState(() {
                                  jsonDataState = json;
                                  isLoadedAPI = true;
                                })
                              }
                          }),
                        );
                        if (jsonDataState != null) getFullProductInfo(0);
                      })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getFullProductInfo(int index) {
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
                          dataFormat(
                              jsonDataState!['data'][index]['id'].toString()),
                          true,
                          context),

                      dataToTextFieldWithLable(
                          'ID sản phẩm',
                          dataFormat(jsonDataState!['data'][index]
                                  ['san_pham_id']
                              .toString()),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'Trạng thái sản phẩm',
                          dataFormat(
                              jsonDataState!['data'][index]['trang_thai']),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'Thời gian thay đổi trạng thái',
                          dataFormat(jsonDataState!['data'][index]['created']
                              .toString()),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'ID người dùng tác động',
                          dataFormat(jsonDataState!['data'][index]['user_id']
                              .toString()),
                          true,
                          context),
                      dataToTextFieldWithLable(
                          'Ghi chú',
                          dataFormat(jsonDataState!['data'][index]['ghi_chu']),
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

  // void searchFilterOptions() {
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (context) => Dialog(
  //       child: Container(
  //         alignment: Alignment.center,

  //         // width: MediaQuery.of(context).size.width - 20,
  //         // height: MediaQuery.of(context).size.height - 20,
  //         padding: const EdgeInsets.all(10),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(30),
  //           ),
  //         ),
  //         child: Column(
  //           children: [
  //             Text(
  //               'Lọc sản phẩm',
  //               style: TextStyle(
  //                 color: Colors.blue.shade200,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 26,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(height: 10),
  //             Expanded(
  //               child: ListView(
  //                 // mainAxisAlignment: MainAxisAlignment.center,
  //                 // crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   textFieldWithPrefixIcon('Từ ngày', Icons.date_range_rounded,
  //                       'date', dateFromController, context),
  //                   textFieldWithPrefixIcon(
  //                       'Đến ngày',
  //                       Icons.date_range_rounded,
  //                       'date',
  //                       dateToController,
  //                       context),
  //                   textFieldWithPrefixIcon('Địa chỉ', Icons.house_rounded,
  //                       'text', addressController, context),
  //                   textFieldWithPrefixIcon(
  //                       'ID nhân viên phụ trách',
  //                       Icons.person_outline_rounded,
  //                       'text',
  //                       idStaffInChargeController,
  //                       context),
  //                   textFieldWithPrefixIcon('ID nhân viên cập nhật',
  //                       Icons.person, 'text', idUpdateStaffController, context),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       SizedBox(width: 5),
  //                       SizedBox(
  //                         width: 90,
  //                         height: 45,
  //                         child: customSizedButton(
  //                           'Lưu',
  //                           context,
  //                           Icons.edit,
  //                           Colors.green,
  //                           10,
  //                           () {
  //                             Navigator.of(context).pop();
  //                           },
  //                         ),
  //                       ),
  //                       SizedBox(
  //                           width: 90,
  //                           height: 45,
  //                           child: customSizedButton('Hủy', context,
  //                               Icons.delete, Colors.red, 10, () {})),
  //                       SizedBox(width: 5),
  //                       // IconButton(
  //                       //   padding: EdgeInsets.only(right: 40),
  //                       //   icon: Icon(
  //                       //     Icons.delete,
  //                       //     color: Colors.red,
  //                       //   ),
  //                       //   onPressed: () {},
  //                       // )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Thông tin sản phẩm',
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
                              (index) {
                                for (var pageItemIndex =
                                        (pageIndex - 1) * infoPerPage + index;
                                    pageItemIndex < infoPerPage * pageIndex &&
                                        pageItemIndex < pageLimit;
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
                          if (pageIndex < pageLimit / infoPerPage) pageIndex++;
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
