// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/list_view/vertical.dart';
import 'package:rcore/utils/text_input/text_input.dart';

class CustomSelect2 extends StatefulWidget {
  final String? hint;
  final List<DropdownMenuItem<Map<String, dynamic>>>? items;
  final double? height;
  const CustomSelect2({Key? key, this.hint, this.items, this.height})
      : super(key: key);
  @override
  State<CustomSelect2> createState() => _CustomSelect2State();
}

class _CustomSelect2State extends State<CustomSelect2> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Map<String, dynamic>>> temp = widget.items!;
    List<DropdownMenuItem<Map<String, dynamic>>> displayItems = temp;
    if (!searchController.text.isEmpty) {
      displayItems = displayItems
          .where((element) => jsonEncode(element.value)
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    return Container(
      padding: EdgeInsets.all(10),
      height: widget.height! - 200,
      child: Column(children: [
        TextField(
            onChanged: (value) {
              setState(() {
                print(1);
              });
            },
            controller: searchController,
            cursorColor: componentPrimaryColor,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(fontSize: 13),
                prefixIcon: Icon(
                  Icons.search,
                  color: themeColor,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                fillColor: Color.fromRGBO(250, 250, 250, 1),
                filled: true),
            style: TextStyle(
              color: Colors.black,
            )),
        Expanded(
            child: ListView(
          children: displayItems,
        ))
      ]),
    );
  }
}

Widget selectTwoNhaLam(String label,
    List<DropdownMenuItem<Map<String, dynamic>>> items, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 5, top: 5),
    // margin: EdgeInsets.only(bottom: 15),
    height: 60,
    decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: themeColor)),
    child: TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                child: CustomSelect2(
                    height: MediaQuery.of(context).size.height - 160,
                    hint: 'Tìm kiếm',
                    items: items)));
      },
      child: Container(
        height: 55,
        padding: EdgeInsets.only(left: 5, right: 10),
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.centerLeft,
          child:
              Text(label, style: TextStyle(color: Colors.black, fontSize: 13)),
        ),
      ),
    ),
  );
}

Widget selectTwoTrailingButton(
    String label,
    List<DropdownMenuItem<Map<String, dynamic>>> items,
    IconData icon,
    Function()? function,
    BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    height: 60,
    decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: themeColor)),
    child: TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                  child: CustomSelect2(
                      height: MediaQuery.of(context).size.height - 160,
                      hint: 'Tìm kiếm',
                      items: items)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 55,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(label, style: TextStyle(color: Colors.black)),
                    )
                  ],
                )),
            TextButton(
                onPressed: function,
                child: Icon(
                  icon,
                  color: themeColor,
                ))
          ],
        )),
  );
}
