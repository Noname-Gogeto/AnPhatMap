// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/utils/images/border_corner_image.dart';

Widget homeListItemWithAssetImage(String imageLink, String subHeader, String header, String price, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                borderCornerImageFromAsset(imageLink, context, 80, 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        price,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    )
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: (){}, 
              child: Icon(
                Icons.edit,
                size: 30,
                color: themeColor
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemWithNetworkImage(String imageLink, String subHeader, String header, String price, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                borderCornerImageFromNetwork(imageLink, context, 80, 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        price,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    )
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: (){}, 
              child: Icon(
                Icons.edit,
                size: 30,
                color: themeColor
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItem(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'Giá tiền :' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Hoa hồng nhân viên :' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: function, 
              child: Icon(
                Icons.edit,
                size: 30,
                color: themeColor
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemTwoButton(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function, Function()? function2) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 170,
              child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subHeader
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 170,
                              child: Flexible(
                                child: Text(
                                  header,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )
                                ),
                              )
                            ),
                            
                            Text(
                              'Giá tiền: ' + priceProduct,
                              style: TextStyle(
                                color: Colors.green,
                              )
                            ),
                            Text(
                              'Hoa hồng nhân viên: ' + priceEmployee,
                              style: TextStyle(
                                color: themeColor,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextButton(
                    onPressed: function, 
                    child: Icon(
                      Icons.edit,
                      size: 30,
                      color: themeColor
                    )
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextButton(
                    onPressed: function2, 
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red
                    )
                  ),
                ),
              ],
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemConfirm(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'ID: ' +  subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'Username: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Số điện thoại: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: function, 
              child: Icon(
                Icons.check,
                size: 30,
                color: Colors.green
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemDelete(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'ID: ' +  subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'SĐT: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Địa chỉ: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: function, 
              child: Icon(
                Icons.delete,
                size: 30,
                color: Colors.red
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemCustomIcon(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'ID: ' +  subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'SĐT: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Địa chỉ: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: function, 
              child: Icon(
                icon,
                size: 30,
                color: color
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemCustomIconProduct(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'Loại: ' +  subHeader
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 150,
                              child: Flexible(
                                child: Text(
                                  header,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )
                                )
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'Giá bán: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Hoa hồng: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            TextButton(
              onPressed: function, 
              child: Icon(
                icon,
                size: 30,
                color: color
              )
            )
          ],
        )
        
      ]
    ),
  );
}
Widget homeListItemBranch(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context, Function()? function, Function()? function2) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             subHeader
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 180,
                              child: Flexible(
                                child: Text(
                                  header,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'SĐT: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Quản lý: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextButton(
                    onPressed: function, 
                    child: Icon(
                      Icons.edit,
                      size: 30,
                      color: themeColor
                    )
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextButton(
                    onPressed: function2, 
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red
                    )
                  ),
                ),
              ],
            )
          ],
        )
      ]
    ),
  );
}
Widget homeListItemManager(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'Username: ' +  subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'SĐT: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Email: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
      ]
    ),
  );
}
Widget homeListItemNearestOrder(String subHeader, String header, String priceProduct, String priceEmployee, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            'Ngày: ' +  subHeader
                            ),
                            Text(
                              header,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Text(
                        'Thành tiền: ' + priceProduct,
                        style: TextStyle(
                          color: Colors.green,
                        )
                      ),
                    ),
                    Container(
                      child: Text(
                        'Nhân viên: ' + priceEmployee,
                        style: TextStyle(
                          color: themeColor,
                        )
                      ),
                    ),
                  ],
                )
              ],
            )
            
          ],
        ),
      ]
    ),
  );
}
Widget horizontalTypeItem(String label, Function()? function, bool active) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: themeColor),
      borderRadius: BorderRadius.all(Radius.circular(100)),
      color: active ? themeColor : Colors.transparent
    ),
    margin: EdgeInsets.only(left: 10, right: 10),
    child: TextButton(
      onPressed: function,
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : themeColor,
        )
      ),
    )
  );
}

Widget drawerItem(String title, IconData icon, bool active, Function()? function) {
  return ListTile(
    leading: Icon(icon, color: active ? themeColor : Colors.black),
    title: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: active ? themeColor : Colors.black
      )
    ),
    onTap: function,
  );
}