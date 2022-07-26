// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_init_to_null, unused_local_variable, use_build_context_synchronously, await_only_futures, prefer_if_null_operators

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/buttons/text_button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/text_input/selection.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:rcore/views/map/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  State<CreateProductScreen> createState() => _CreateProductScreen();
}

class _CreateProductScreen extends State<CreateProductScreen> {
  TextEditingController chieuDaiController = TextEditingController();
  TextEditingController chieuRongController = TextEditingController();
  TextEditingController soTangController = TextEditingController();
  TextEditingController soCanController = TextEditingController();
  TextEditingController doRongDuongController = TextEditingController();
  TextEditingController dienTichController = TextEditingController();
  TextEditingController giaTienController = TextEditingController();
  TextEditingController hoaHongController = TextEditingController();
  TextEditingController phapLyController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController hoTenChuHoController = TextEditingController();
  TextEditingController soDienThoaiController = TextEditingController();
  TextEditingController ghiChuController = TextEditingController();

  Map<String, dynamic>? selectedLoaiSanPham = null;
  Map<String, dynamic>? selectedPhanLoai = null;
  Map<String, dynamic>? selectedHuong = null;
  Map<String, dynamic>? selectedLoaiHoaHong = null;
  Map<String, dynamic>? selectedXaPhuong = null;
  Map<String, dynamic>? selectedDuongPho = null;
  Map<String, dynamic>? selectedThonXom = null;
  Map<String, dynamic>? selectedPhapLy = null;
  Map<String, dynamic>? userInfo = null;

  List<dynamic>? jsonLoaiSanPham = null;
  List<dynamic>? jsonPhanLoai = null;
  List<dynamic>? jsonHuong = null;
  List<dynamic>? jsonLoaiHoaHong = null;
  List<dynamic>? jsonXaPhuong = null;
  List<dynamic>? jsonDuongPho = null;
  List<dynamic>? jsonThonXom = null;
  List<dynamic>? jsonPhapLy = null;

  @override
  Widget build(BuildContext context) {
    if(userInfo == null) {
      SharedPreferences.getInstance().then((prefs) => ({
        setState(() {
          userInfo = jsonDecode(prefs.getString('userInfo')!);
        })
      }));
    }
    if(userInfo != null && jsonLoaiSanPham == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Loại sản phẩm',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonLoaiSanPham = json!['data'];
        })
      })); 
    }
    if(userInfo != null && jsonPhanLoai == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Phân loại',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonPhanLoai = json!['data'];
        })
      }));
    }
    if(userInfo != null && jsonHuong == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Hướng',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonHuong = json!['data'];
        })
      }));
    }
    if(userInfo != null && jsonLoaiHoaHong == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Loại hoa hồng',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonLoaiHoaHong = json!['data'];
        })
      }));
    }
    if(userInfo != null && jsonXaPhuong == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Phường xã',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonXaPhuong = json!['data'];
        })
      }));
    }
    if(userInfo != null && jsonDuongPho == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Đường phố',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonDuongPho = json!['data'];
        })
      }));
    }
    if(userInfo != null && jsonThonXom == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Thôn xóm',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonThonXom = json!['data'];
        })
      }));
    }   
    if(userInfo != null && jsonPhapLy == null) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-danh-muc', context, 'POST', {
        'type': 'Pháp lý',
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
        setState(() {
          jsonPhapLy = json!['data'];
        })
      }));
    }   

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              contentHeaderWithoutAdd('Thông tin sản phẩm'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: defaultSelection('Phân loại', 
                    jsonPhanLoai == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                      .generate(jsonPhanLoai!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                        value: jsonPhanLoai![index],
                        child: Text(jsonPhanLoai![index]['name']),
                      )), 
                    selectedPhanLoai, (value) {
                      setState(() {
                        selectedPhanLoai = value;
                      });
                    })
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: defaultSelection('Chọn loại sản phẩm', 
                    jsonLoaiSanPham == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                      .generate(jsonLoaiSanPham!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                        value: jsonLoaiSanPham![index],
                        child: Text(jsonLoaiSanPham![index]['name']),
                      )), 
                    selectedLoaiSanPham, (value) {
                      setState(() {
                        selectedLoaiSanPham = value;
                      });
                    })
                  )
                ],
              ),
              selectedLoaiSanPham != null && selectedLoaiSanPham!['name'] == 'Nhà' ? defaultSelection('Chọn hướng', 
                jsonHuong == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                  .generate(jsonHuong!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                    value: jsonHuong![index],
                    child: Text(jsonHuong![index]['name']),
                  )), 
                selectedHuong, (value) {
                  setState(() {
                    selectedHuong = value;
                  });
                }) : Container(),
              selectedLoaiSanPham != null && selectedLoaiSanPham!['name'] == 'Nhà' ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Chiều dài (m)', 'number', chieuDaiController, context, () {
                      if(!chieuDaiController.text.isEmpty && !chieuRongController.text.isEmpty) {
                        dienTichController.text = (int.parse(chieuDaiController.text) * int.parse(chieuRongController.text)).toString();
                      }
                    })
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Chiều rộng (m)', 'number', chieuRongController, context, () {
                      if(!chieuDaiController.text.isEmpty && !chieuRongController.text.isEmpty) {
                        dienTichController.text = (int.parse(chieuDaiController.text) * int.parse(chieuRongController.text)).toString();
                      }
                    })
                  ),
                ],
              ) : Container(),
              selectedLoaiSanPham != null && selectedLoaiSanPham!['name'] == 'Nhà' ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Số tầng', 'number', soTangController, context, () {})
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Số căn', 'number', soCanController, context, () {})
                  ),
                ],
              ) : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Độ rộng đường (m)', 'number', doRongDuongController, context, () {})
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Diện tích (m2)', 'number', dienTichController, context, () {})
                  ),
                ],
              ),
              contentHeaderWithoutAdd('Giá cả'),
              textFieldWithPlaceholder('Giá bán', 'number', giaTienController, context, () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: defaultSelection('Chọn loại hoa hồng', 
                    jsonLoaiHoaHong == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                      .generate(jsonLoaiHoaHong!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                        value: jsonLoaiHoaHong![index],
                        child: Text(jsonLoaiHoaHong![index]['name']),
                      )), 
                    selectedLoaiHoaHong, (value) {
                      selectedLoaiHoaHong = value;
                    })
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    child: textFieldWithPlaceholder('Hoa hồng', 'number', hoaHongController, context, () {})
                  ),
                ],
              ),
              contentHeaderWithoutAdd('Vị trí địa lý'),
              defaultSelection('Chọn xã phường', 
                jsonXaPhuong == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                  .generate(jsonXaPhuong!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                    value: jsonXaPhuong![index],
                    child: Text(jsonXaPhuong![index]['name']),
                  )), 
                selectedXaPhuong, (value) {
                  setState(() {
                    selectedXaPhuong = value;
                  });
                }),
              defaultSelection('Chọn đường phố', 
                jsonDuongPho == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                  .generate(jsonDuongPho!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                    value: jsonDuongPho![index],
                    child: Text(jsonDuongPho![index]['name']),
                  )), 
                selectedDuongPho, (value) {
                  setState(() {
                    selectedDuongPho = value;
                  });
                }),
              defaultSelection('Chọn thôn xóm', 
                jsonThonXom == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                  .generate(jsonThonXom!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                    value: jsonThonXom![index],
                    child: Text(jsonThonXom![index]['name']),
                  )), 
                selectedThonXom, (value) {
                  setState(() {
                    selectedThonXom = value;
                  });
                }),
              textFieldWithPlaceholder('Địa chỉ', 'text', diaChiController, context, () {}),
              contentHeaderWithoutAdd('Thông tin thêm'),
              textFieldWithPlaceholder('Họ tên chủ sở hữu', 'text', hoTenChuHoController, context, () {}),
              textFieldWithPlaceholder('Số điện thoại', 'text', soDienThoaiController, context, () {}),
              //textFieldWithPlaceholder('Pháp lý', 'text', phapLyController, context, () {}),
              defaultSelection('Chọn pháp lý', 
                jsonPhapLy == null ? [] : List<DropdownMenuItem<Map<String, dynamic>>>
                  .generate(jsonPhapLy!.length, (index) => DropdownMenuItem<Map<String, dynamic>>(
                    value: jsonPhapLy![index],
                    child: Text(jsonPhapLy![index]['name']),
                  )), 
                selectedPhapLy, (value) {
                  setState(() {
                    selectedPhapLy = value;
                  });
                }),
              textFieldWithPlaceholder('Ghi chú', 'multiline', ghiChuController, context, () {}),
              primarySizedButton('Tạo mới', context, () async {
                var prefs = await SharedPreferences.getInstance();
                String? coords = await prefs.getString('selectedCoord');
                GetAPI('https://anphat.andin.io/index.php?r=service/save-san-pham', context, 'POST', {
                  'id': '',
                  'toa_do_vi_tri': coords != null ? coords : '',
                  'phan_loai': selectedPhanLoai != null ? selectedPhanLoai!['id'].toString() : '',
                  'type': selectedLoaiSanPham != null ? selectedLoaiSanPham!['id'].toString() : '',
                  'xa_phuong_id': selectedXaPhuong != null ? selectedXaPhuong!['id'].toString() : '',
                  'duong_pho_id': selectedDuongPho != null ? selectedDuongPho!['id'].toString() : '',
                  'thon_xom_id': selectedThonXom != null ? selectedThonXom!['id'].toString() : '',
                  'gia_tu': giaTienController.text,
                  'dia_chi': diaChiController.text,
                  'huong': selectedHuong != null ? selectedHuong!['name'] : '',
                  'chieu_dai': chieuDaiController.text,
                  'chieu_rong': chieuRongController.text,
                  'so_tang': soTangController.text,
                  'so_can': soCanController.text,
                  'duong': doRongDuongController.text,
                  'dien_tich': dienTichController.text,
                  'loai_hoa_hong': selectedLoaiHoaHong != null ? selectedLoaiHoaHong!['id'].toString() : '',
                  'hoa_hong': hoaHongController.text,
                  'phap_ly': selectedPhapLy != null ? selectedPhapLy!['id'].toString() : '',
                  'ghi_chu': ghiChuController.text,
                  'chu_nha': hoTenChuHoController.text,
                  'dien_thoai_chu_nha': soDienThoaiController.text,
                  'nguoi_tao_id': userInfo!['id'].toString(),
                  'user_id': userInfo!['id'].toString(),
                  'uid': userInfo!['id'].toString(),
                  'auth': userInfo!['auth_key'],
                }).then((Map<String, dynamic>? json) => ({
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapScreen()))
                }));
              })
            ],
          )
        )
      )
    );
    
  }
}