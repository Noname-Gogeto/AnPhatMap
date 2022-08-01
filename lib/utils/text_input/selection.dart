// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/text_input/text_input.dart';
import 'package:search_choices/search_choices.dart';

Widget dialogSelection(List<Widget> widgets, String label, BuildContext context) {
  TextEditingController searchController = TextEditingController();
  return TextButton(
    onPressed: () {
      showDialog(
        context: context, 
        builder: (context) => Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 600,
            padding: EdgeInsets.all(10),
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: widgets,
                  ),
                ),
              ],
            )
            
          )
        ));
    }, 
    child: Container(
      height: 55,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black
          )
        ),
      )
    )
  );
}

Widget select2(List<DropdownMenuItem<Map<String, dynamic>>> listItem, String hint) {
  return SearchChoices<Map<String, dynamic>>.single(
    items: listItem,
    value: Map(),
    hint: hint,
    searchHint: "Tìm kiếm",
    onChanged: (value) {
    },
    isExpanded: true,
    searchInputDecoration: InputDecoration(
      focusedBorder: OutlineInputBorder(  
        borderSide: BorderSide(color: themeColor),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      enabledBorder: OutlineInputBorder(  
        borderSide: BorderSide(color: themeColor),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      fillColor: Color.fromRGBO(250, 250, 250, 1),
      filled: true
    ),
  );
}

Widget defaultSelection(String hint, List<DropdownMenuItem<Map<String, dynamic>>> widgets, Map<String, dynamic>? selectedValue, Function(Map<String, dynamic>? value)? onChanged ) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 10),
    decoration: BoxDecoration(
      color: Color.fromRGBO(250, 250, 250, 1),
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: themeColor)
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<Map<String, dynamic>?>(
        value: selectedValue,
        onChanged: onChanged,
        hint: Text(hint),
        iconSize: 0,
        items: widgets,
      ),
    )
  );
}