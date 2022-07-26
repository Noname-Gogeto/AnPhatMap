// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';

class DetailsProductsListScreen extends StatefulWidget {
  final Map<String, dynamic>? jsonData;
  final int? productIndex;
  const DetailsProductsListScreen({Key? key, this.jsonData, this.productIndex})
      : super(key: key);

  @override
  State<DetailsProductsListScreen> createState() =>
      _DetailsProductsListScreenState();
}

class _DetailsProductsListScreenState extends State<DetailsProductsListScreen> {
  String dataFormat(String? str) => (str == null || str == '') ? '' : str;

  Widget getFullproductInfo(int? index) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        dataToTextFieldWithLable(
            'ID',
            dataFormat(widget.jsonData!['content'][index]['id'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Phân loại',
            dataFormat(
                widget.jsonData!['content'][index]['phan_loai'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Chủ nhà',
            dataFormat(
                widget.jsonData!['content'][index]['chu_nha'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Điện thoại chủ nhà',
            dataFormat(widget.jsonData!['content'][index]['dien_thoai_chu_nha']
                .toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Loại',
            dataFormat(widget.jsonData!['content'][index]['type'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Địa chỉ',
            dataFormat(
                widget.jsonData!['content'][index]['dia_chi'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Chiều rộng',
            dataFormat(
                widget.jsonData!['content'][index]['chieu_rong'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Chiều dài',
            dataFormat(
                widget.jsonData!['content'][index]['chieu_dai'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Diện tích',
            dataFormat(
                widget.jsonData!['content'][index]['dien_tich'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Hướng',
            dataFormat(widget.jsonData!['content'][index]['huong'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Đường',
            dataFormat(widget.jsonData!['content'][index]['duong'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Số tầng',
            dataFormat(
                widget.jsonData!['content'][index]['so_tang'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Số căn',
            dataFormat(widget.jsonData!['content'][index]['so_can'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Giá từ',
            dataFormat(widget.jsonData!['content'][index]['gia_tu'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Pháp lý',
            dataFormat(
                widget.jsonData!['content'][index]['phap_ly'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Loại hoa hồng',
            dataFormat(
                widget.jsonData!['content'][index]['loai_hoa_hong'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Hoa hồng',
            dataFormat(
                widget.jsonData!['content'][index]['hoa_hong'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Ngày tạo',
            dataFormat(
                widget.jsonData!['content'][index]['ngay_tao'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Trạng thái',
            dataFormat(
                widget.jsonData!['content'][index]['trang_thai'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'ID Người tạo',
            dataFormat(
                widget.jsonData!['content'][index]['nguoi_tao_id'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'ID Nhân viên phụ trách',
            dataFormat(widget.jsonData!['content'][index]
                    ['nhan_vien_phu_trach_id']
                .toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Ghi chú',
            dataFormat(
                widget.jsonData!['content'][index]['ghi_chu'].toString()),
            true,
            context),
        dataToTextFieldWithLable(
            'Tọa độ vị trí',
            dataFormat(
                widget.jsonData!['content'][index]['toa_do_vi_tri'].toString()),
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
        //           'Sửa', context, Icons.edit, Colors.green, 10, () {}),
        //     ),
        //     SizedBox(
        //         width: 90,
        //         height: 45,
        //         child: customSizedButton(
        //             'Xóa', context, Icons.delete, Colors.red, 10, () {})),
        //     SizedBox(width: 5),
        //   ],
        // ),
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
