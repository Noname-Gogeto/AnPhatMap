// ignore_for_file: prefer_const_constructors, avoid_init_to_null

import 'package:flutter/material.dart';
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
  Map<String, dynamic>? userInfo = null;
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
          height: MediaQuery.of(context).size.height * 0.5,
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
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    dataToTextFieldWithLableInDialog(
                        'ID',
                        dataFormat(
                            jsonDataState!['data'][index]['id'].toString()),
                        true,
                        context),
                    dataToTextFieldWithLableInDialog(
                        'ID sản phẩm',
                        dataFormat(jsonDataState!['data'][index]['san_pham_id']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLableInDialog(
                        'Trạng thái sản phẩm',
                        dataFormat(jsonDataState!['data'][index]['trang_thai']),
                        true,
                        context),
                    dataToTextFieldWithLableInDialog(
                        'Thời gian thay đổi trạng thái',
                        dataFormat(jsonDataState!['data'][index]['created']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLableInDialog(
                        'ID người dùng tác động',
                        dataFormat(jsonDataState!['data'][index]['user_id']
                            .toString()),
                        true,
                        context),
                    dataToTextFieldWithLableInDialog(
                        'Ghi chú',
                        dataFormat(jsonDataState!['data'][index]['ghi_chu']),
                        true,
                        context),
                  ],
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
        SizedBox(height: 20),
        dataToTextFieldWithLable2(
            'ID',
            dataFormat(widget.jsonData!['content'][index]['id'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Phân loại',
            dataFormat(
                widget.jsonData!['content'][index]['phan_loai'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Chủ nhà',
            dataFormat(
                widget.jsonData!['content'][index]['chu_nha'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Điện thoại chủ nhà',
            dataFormat(widget.jsonData!['content'][index]['dien_thoai_chu_nha']
                .toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Loại',
            dataFormat(widget.jsonData!['content'][index]['type'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Địa chỉ',
            dataFormat(
                widget.jsonData!['content'][index]['dia_chi'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Chiều rộng',
            dataFormat(
                widget.jsonData!['content'][index]['chieu_rong'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Chiều dài',
            dataFormat(
                widget.jsonData!['content'][index]['chieu_dai'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Diện tích',
            dataFormat(
                widget.jsonData!['content'][index]['dien_tich'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Hướng',
            dataFormat(widget.jsonData!['content'][index]['huong'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Đường',
            dataFormat(widget.jsonData!['content'][index]['duong'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Số tầng',
            dataFormat(
                widget.jsonData!['content'][index]['so_tang'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Số căn',
            dataFormat(widget.jsonData!['content'][index]['so_can'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Giá từ',
            dataFormat(widget.jsonData!['content'][index]['gia_tu'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Pháp lý',
            dataFormat(
                widget.jsonData!['content'][index]['phap_ly'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Loại hoa hồng',
            dataFormat(
                widget.jsonData!['content'][index]['loai_hoa_hong'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Hoa hồng',
            dataFormat(
                widget.jsonData!['content'][index]['hoa_hong'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Ngày tạo',
            dataFormat(
                widget.jsonData!['content'][index]['ngay_tao'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Trạng thái',
            dataFormat(
                widget.jsonData!['content'][index]['trang_thai'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'ID Người tạo',
            dataFormat(
                widget.jsonData!['content'][index]['nguoi_tao_id'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'ID Nhân viên phụ trách',
            dataFormat(widget.jsonData!['content'][index]
                    ['nhan_vien_phu_trach_id']
                .toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Ghi chú',
            dataFormat(
                widget.jsonData!['content'][index]['ghi_chu'].toString()),
            true,
            context),
        dataToTextFieldWithLable2(
            'Tọa độ vị trí',
            dataFormat(
                widget.jsonData!['content'][index]['toa_do_vi_tri'].toString()),
            true,
            context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              height: 45,
              child: primarySizedButton('Lịch sử', context, () async {
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
      backgroundColor: const Color.fromARGB(255, 244, 242, 242),
      body: getFullproductInfo(widget.productIndex),
    );
  }
}
