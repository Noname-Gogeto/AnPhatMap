// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_init_to_null, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../controller/ServicesController.dart';
import '../../utils/buttons/button.dart';
import '../../utils/buttons/text_button.dart';
import '../../utils/color/theme.dart';
import '../../utils/dialogs/dialog.dart';

class SellProductScreen extends StatefulWidget {
  final Map<String, dynamic>? userInfo;
  final Map<String, dynamic>? jsonData;
  final int? productIndex;
  const SellProductScreen({
    Key? key,
    this.userInfo,
    this.jsonData,
    this.productIndex,
  }) : super(key: key);

  @override
  State<SellProductScreen> createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  Map<String, dynamic>? jsonData = null;
  bool isLoadedAPI = false;
  TextEditingController sellType = TextEditingController();
  TextEditingController moneyProduct = TextEditingController();
  TextEditingController idSeller = TextEditingController();
  TextEditingController dateSeller = TextEditingController();
  TextEditingController sellerType = TextEditingController();
  TextEditingController stateProduct = TextEditingController();
  String indexSellType = 'Nhân viên';
  String indexStateProduct = 'Đã bán';
  Map<String, dynamic>? selectedItem = null;
  List<DropdownMenuItem<Map<String, dynamic>>>? items = null;

  @override
  // ignore: must_call_super
  void initState() {
    moneyProduct.text = '0';
    idSeller.text = '0';
    sellerType.text = 'Nhân viên';
    stateProduct.text = 'Đã bán';
  }

  String dataFormat(String? str) => (str == null || str == '') ? '' : str;

  void getDataEmployee() {
    if (!isLoadedAPI) {
      GetAPI('https://anphat.andin.io/index.php?r=restful-api/list-thanh-vien',
          context, 'POST', {
        'uid': widget.userInfo!['id'].toString(),
        'auth': widget.userInfo!['auth_key'].toString(),
      }).then(
        (Map<String, dynamic>? json) => ({
          if (json != null)
            {
              setState(() {
                jsonData = json;
                isLoadedAPI = true;
              }),
              items = List<DropdownMenuItem<Map<String, dynamic>>>.generate(
                jsonData!['data'].length,
                (index) => DropdownMenuItem(
                  value: jsonData!['data'][index],
                  child: Text(jsonData!['data'][index]['id'].toString()),
                ),
              ),
            }
        }),
      );
    }
  }

  Widget moneyTypePeople(String type) {
    // idSeller.text = '';
    if (type == 'Nhân viên') {
      return Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: 'ID nguời bán',
            labelStyle:
                TextStyle(color: buttonPrimaryColorActive, fontSize: 24),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            fillColor: Color.fromARGB(255, 244, 242, 242),
          ),
          items: items,
          value: selectedItem,
          onChanged: (Map<String, dynamic>? value) {
            selectedItem = value;
            idSeller.text = value.toString();
            setState(() {});
          },
        ),
      );
      // selectTwoNhaLam(
      //     selectedItem == null ? 'hiihi' : 'hih',
      //     List<DropdownMenuItem<Map<String, dynamic>>>.generate(
      //         jsonData!['data'].length,
      //         (index) => DropdownMenuItem<Map<String, dynamic>>(
      //               value: jsonData!['data'][index],
      //               child: Text(jsonData!['data'][index]['hoten']),
      //             )),
      //     context);
    }
    return dataToTextFieldWithLable(
        'ID người bán', idSeller.text, false, context,
        textController: idSeller);
  }

  Widget getFullproductInfo(int? index) {
    return ListView(
      children: [
        dataToTextFieldWithLable(
            'ID sản phẩm',
            dataFormat(widget.jsonData!['content'][index]['id'].toString()),
            true,
            context),
        Container(
          height: 90,
          padding: EdgeInsets.only(left: 50, right: 50),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Kiểu người bán',
              labelStyle:
                  TextStyle(color: buttonPrimaryColorActive, fontSize: 24),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: Color.fromARGB(255, 244, 242, 242),
            ),
            borderRadius: BorderRadius.circular(15.0),
            alignment: AlignmentDirectional.center,
            items: [
              DropdownMenuItem(
                value: 'Nhân viên',
                child: Text(
                  'Nhân viên',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'Chủ nhà',
                child: Text(
                  'Chủ nhà',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'Đơn vị khác',
                child: Text(
                  'Đơn vị khác',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            value: indexSellType,
            onChanged: (String? value) {
              indexSellType = value!;
              sellerType.text = indexSellType;
              setState(() {});
            },
          ),
        ),
        dataToTextFieldWithLable(
            'Số tiền bán', moneyProduct.text, false, context,
            textController: moneyProduct),
        moneyTypePeople(indexSellType),
        dataToTextFieldWithLable('Ngày bán', '', false, context,
            inputType: 'date', textController: dateSeller),
        Container(
          height: 90,
          padding: EdgeInsets.only(left: 50, right: 50),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: 'Trạng thái',
              labelStyle:
                  TextStyle(color: buttonPrimaryColorActive, fontSize: 24),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: Color.fromARGB(255, 244, 242, 242),
            ),
            borderRadius: BorderRadius.circular(15.0),
            alignment: AlignmentDirectional.center,
            items: [
              DropdownMenuItem(
                value: 'Đã bán',
                child: Text(
                  'Đã bán',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'Đã bán một phần',
                child: Text(
                  'Đã bán một phần',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            value: indexStateProduct,
            onChanged: (String? value) {
              indexStateProduct = value!;
              stateProduct.text = indexStateProduct;
              setState(() {});
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            SizedBox(
              width: 90,
              height: 45,
              child: customSizedButton(
                  'Bán', context, Icons.edit, Colors.green, 10, () {
                GetAPI(
                    'https://anphat.andin.io/index.php?r=restful-api/ban-hang',
                    context,
                    'POST', {
                  'uid': widget.userInfo!['id'].toString(),
                  'auth': widget.userInfo!['auth_key'].toString(),
                  'san_pham_id':
                      widget.jsonData!['content'][index]['id'].toString(),
                  'kieu_nguoi_ban': sellerType.text,
                  'so_tien': moneyProduct.text,
                  'ngay_ban': dateSeller.text,
                  'nguoi_ban_id': idSeller.text,
                  'trang_thai': stateProduct.text,
                }).then((Map<String, dynamic>? json) => ({
                      if (json != null)
                        {
                          notiDialog('Thông báo', json['message'], () async {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }, context)
                        }
                    }));
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
    getDataEmployee();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Bán sản phẩm',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: buttonPrimaryColorDeactive),
      ),
      backgroundColor: Color.fromARGB(255, 244, 242, 242),
      body: getFullproductInfo(widget.productIndex),
    );
  }
}
