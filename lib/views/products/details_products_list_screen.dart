// ignore_for_file: prefer_const_constructors, avoid_init_to_null

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';

class DetailsProductsListScreen extends StatefulWidget {
  final Map<String, dynamic>? jsonData;
  final Map<String, dynamic>? userInfo;
  final int? productIndex;
  const DetailsProductsListScreen(
      {Key? key, this.jsonData, this.productIndex, this.userInfo})
      : super(key: key);

  @override
  State<DetailsProductsListScreen> createState() =>
      _DetailsProductsListScreenState();
}

class _DetailsProductsListScreenState extends State<DetailsProductsListScreen> {
  String dataFormat(String? str) =>
      (str == null || str == '' || str == 'null') ? '' : str;
  String numberFormat(String str) {
    return dataFormat(str) == ''
        ? ''
        : NumberFormat().format(double.parse(dataFormat(str)));
  }

  String pricePercentEmployee(str) {
    if (dataFormat(widget.jsonData!['content'][widget.productIndex]
                ['loai_hoa_hong']
            .toString()) ==
        'Phần trăm') {
      return '$str%';
    }
    return '${str}VNĐ';
  }

  Map<String, dynamic>? jsonDataState = null;
  bool isLoadedAPI = false;

  void getStateProductInfo(int index) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        // elevation: MediaQuery.of(context).size.height - 500,
        child: Container(
          alignment: Alignment.center,
          // width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height * 0.25,
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
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      // dataToTextFieldWithLableInDialog(
                      //     'ID',
                      //     dataFormat(
                      //         jsonDataState!['data'][index]['id'].toString()),
                      //     true,
                      //     context, highContrast : true),
                      // dataToTextFieldWithLableInDialog(
                      //     'ID sản phẩm',
                      //     dataFormat(jsonDataState!['data'][index]['san_pham_id']
                      //         .toString()),
                      //     true,
                      //     context, highContrast : true),
                      dataToTextFieldWithLableInDialog(
                          'Thời gian thay đổi trạng thái',
                          dataFormat(jsonDataState!['data'][index]['created']
                              .toString()),
                          true,
                          context),
                      dataToTextFieldWithLableInDialog(
                          'Trạng thái sản phẩm',
                          dataFormat(
                              jsonDataState!['data'][index]['trang_thai']),
                          true,
                          context),
                      // dataToTextFieldWithLableInDialog(
                      //     'ID người dùng tác động',
                      //     dataFormat(jsonDataState!['data'][index]['user_id']
                      //         .toString()),
                      //     true,
                      //     context, highContrast : true),
                      // dataToTextFieldWithLableInDialog(
                      //     'Ghi chú',
                      //     dataFormat(jsonDataState!['data'][index]['ghi_chu']),
                      //     true,
                      //     context, highContrast : true),
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

  Widget getFullproductInfo(int? index) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            'Thông tin chủ nhà',
            style: TextStyle(
                fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'Họ tên chủ nhà',
                dataFormat(
                    widget.jsonData!['content'][index]['chu_nha'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'Điện thoại chủ nhà',
                dataFormat(widget.jsonData!['content'][index]
                        ['dien_thoai_chu_nha']
                    .toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(
            'Thông tin sản phẩm',
            style: TextStyle(
                fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        // dataToTextFieldWithLable2(
        //     'ID',
        //     dataFormat(widget.jsonData!['content'][index]['id'].toString()),
        //     true,
        //     context,
        //     highContrast: true),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'Phân loại',
                dataFormat(
                    widget.jsonData!['content'][index]['phan_loai'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'Loại',
                dataFormat(
                    widget.jsonData!['content'][index]['type'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'Chiều rộng',
                numberFormat(widget.jsonData!['content'][index]['chieu_rong']
                    .toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'Chiều dài',
                numberFormat(
                    widget.jsonData!['content'][index]['chieu_dai'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'Số tầng',
                dataFormat(
                    widget.jsonData!['content'][index]['so_tang'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'Số căn',
                numberFormat(
                    widget.jsonData!['content'][index]['so_can'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        dataToTextFieldWithLable2(
            'Địa chỉ',
            dataFormat(
                widget.jsonData!['content'][index]['dia_chi'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Diện tích',
            numberFormat(
                widget.jsonData!['content'][index]['dien_tich'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Hướng',
            dataFormat(widget.jsonData!['content'][index]['huong'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Đường',
            dataFormat(widget.jsonData!['content'][index]['duong'].toString()),
            true,
            context,
            highContrast: true),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Giá cả',
            style: TextStyle(
                fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        dataToTextFieldWithLable2(
            'Giá từ',
            numberFormat(
                widget.jsonData!['content'][index]['gia_tu'].toString()),
            true,
            context,
            highContrast: true),

        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'Loại hoa hồng',
                dataFormat(widget.jsonData!['content'][index]['loai_hoa_hong']
                    .toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'Hoa hồng',
                pricePercentEmployee(
                    widget.jsonData!['content'][index]['hoa_hong'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Thông tin thêm',
            style: TextStyle(
                fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'Ngày tạo',
                dataFormat(
                    widget.jsonData!['content'][index]['ngay_tao'].toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'Trạng thái',
                dataFormat(widget.jsonData!['content'][index]['trang_thai']
                    .toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataToTextFieldWithLable2(
                'ID Người tạo',
                dataFormat(widget.jsonData!['content'][index]['nguoi_tao_id']
                    .toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
              dataToTextFieldWithLable2(
                'ID Nhân viên phụ trách',
                dataFormat(widget.jsonData!['content'][index]
                        ['nhan_vien_phu_trach_id']
                    .toString()),
                true,
                context,
                highContrast: true,
                sizeWidth: (MediaQuery.of(context).size.width) * 0.5 - 15,
              ),
            ],
          ),
        ),
        dataToTextFieldWithLable2(
            'Pháp lý',
            dataFormat(
                widget.jsonData!['content'][index]['phap_ly'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Ghi chú',
            dataFormat(
                widget.jsonData!['content'][index]['ghi_chu'].toString()),
            true,
            context,
            highContrast: true),
        dataToTextFieldWithLable2(
            'Tọa độ vị trí',
            dataFormat(
                widget.jsonData!['content'][index]['toa_do_vi_tri'].toString()),
            true,
            context,
            highContrast: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 45,
              child:
                  primarySizedButton('Lịch sử trạng thái', context, () async {
                await GetAPI(
                    'https://anphat.andin.io/index.php?r=restful-api/get-lich-su-trang-thai',
                    context,
                    'POST', {
                  'uid': widget.userInfo!['id'].toString(),
                  'auth': widget.userInfo!['auth_key'].toString(),
                  'id': widget.jsonData!['content'][index]['id'].toString(),
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
                if (jsonDataState != null) getStateProductInfo(0);
              }),
            ),
            // SizedBox(
            //     width: 90,
            //     height: 45,
            //     child: customSizedButton(
            //         'Xóa', context, Icons.delete, Colors.red, 10, () {})),
            // SizedBox(width: 5),
          ],
        ),
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
      // backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      backgroundColor: Colors.white,
      body: getFullproductInfo(widget.productIndex),
    );
  }
}
