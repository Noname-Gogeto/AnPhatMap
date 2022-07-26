// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields, prefer_interpolation_to_compose_strings, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_init_to_null

import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rcore/controller/ServicesController.dart';
import 'package:rcore/utils/buttons/button.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:rcore/views/products/products_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.8449216, 106.6880955),
    zoom: 14.4746,
  );

  static final CameraPosition currentPosition = CameraPosition(
      target: LatLng(20.8449216, 106.6880955), zoom: 19.151926040649414);
  List<Marker> _markers = [];

  Map<String, dynamic>? jsonData = null;
  Map<String, dynamic>? userInfo = null;
  bool loadedData = false;
  bool loadedDefaultPin = false;
  BottomDrawerController bottomController = BottomDrawerController();
  BitmapDescriptor? pinIconDefault = null;

  Map<String, dynamic>? selectedProduct = null;

  @override
  Widget build(BuildContext context) {
    if (pinIconDefault == null) {
      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(30, 40)),
              'lib/assets/icons/pin-red.png')
          .then((value) => setState(() {
                pinIconDefault = value;
              }));
    }
    if (userInfo == null) {
      SharedPreferences.getInstance().then((prefs) => ({
            setState(() {
              userInfo = jsonDecode(prefs.getString('userInfo')!);
            })
          }));
    }

    if (userInfo != null && !loadedData) {
      GetAPI('https://anphat.andin.io/index.php?r=service/get-data-san-pham',
          context, 'POST', {
        'uid': userInfo!['id'].toString(),
        'auth': userInfo!['auth_key'],
      }).then((Map<String, dynamic>? json) => ({
            setState(() {
              jsonData = json;
              loadedData = true;
            })
          }));
    }
    if (loadedData && pinIconDefault != null) {
      _markers.addAll(List<Marker>.generate(
          jsonData!['content'].length,
          (index) => Marker(
              markerId: MarkerId(DateTime.now().toString() + index.toString()),
              position: LatLng(
                  double.parse(jsonData!['content'][index]['toa_do_vi_tri']
                      .toString()
                      .split(',')
                      .first),
                  double.parse(jsonData!['content'][index]['toa_do_vi_tri']
                      .toString()
                      .split(',')
                      .last)),
              infoWindow: InfoWindow(
                title: NumberFormat().format(double.parse(
                        jsonData!['content'][index]['gia_tu'].toString())) +
                    ' VNĐ',
                onTap: () {
                  setState(() {
                    selectedProduct = jsonData!['content'][index];
                  });
                  globalKey.currentState!.openDrawer();
                },
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed))));
    }
    if (!loadedDefaultPin) {
      Location loc = Location();
      _controller.future.then((controller) => ({
            loc.getLocation().then((LocationData data) => ({
                  if (data.longitude != null && data.latitude != null)
                    {
                      controller.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(data.latitude!, data.longitude!),
                              zoom: 20))),
                      setState(() {
                        _markers = [];
                        _markers.add(Marker(
                            markerId: MarkerId(data.toString() + '2'),
                            position: LatLng(data.latitude!, data.longitude!),
                            draggable: true,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueCyan),
                            infoWindow: InfoWindow(
                                title: 'Chạm để tạo sản phẩm ở vị này ?'),
                            onTap: () async {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'selectedCoord',
                                  data.latitude.toString() +
                                      ',' +
                                      data.longitude.toString());
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateProductScreen()));
                            }));
                        loadedDefaultPin = true;
                      }),
                    }
                }))
          }));
    }
    return new Scaffold(
      key: globalKey,
      drawer: selectedProduct == null
          ? Container()
          : BottomDrawer(
              controller: bottomController,
              drawerHeight: MediaQuery.of(context).size.height - 200,
              headerHeight: 200,
              header: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: themeColor)),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(12),
                      //   topRight: Radius.circular(12),
                      // ),
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/product-demo.jpg'),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                        opacity: 0.3,
                      )),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(selectedProduct!['ngay_tao'] + ' ',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                              Icon(Icons.calendar_month),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(selectedProduct!['chu_nha'].toString() + ' ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.person,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  selectedProduct!['dien_thoai_chu_nha']
                                          .toString() +
                                      ' ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                Icons.phone,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  NumberFormat().format(double.parse(
                                      selectedProduct!['gia_tu'].toString())),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: themeColor,
                                  )),
                              Icon(Icons.attach_money, color: themeColor),
                            ],
                          ),
                        ]),
                  )),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 300,
                padding: EdgeInsets.all(15),
                child: ListView(children: [
                  Text('Chi tiết',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: themeColor)),
                  twoTextBetween('Phân loại', selectedProduct!['phan_loai']),
                  twoTextBetween('Loại sản phẩm', selectedProduct!['type']),
                  twoTextBetween('Địa chỉ', selectedProduct!['dia_chi']),
                  twoTextBetween(
                      'Độ rộng mặt đường',
                      selectedProduct!['duong'] == null
                          ? 'Chưa mô tả'
                          : selectedProduct!['duong'].toString() + ' (m)'),
                  twoTextBetween(
                      'Chiều dài',
                      selectedProduct!['chieu_dai'] == null
                          ? 'Chưa mô tả'
                          : selectedProduct!['chieu_dai'].toString() + ' (m)'),
                  twoTextBetween(
                      'Chiều rộng',
                      selectedProduct!['chieu_rong'] == null
                          ? 'Chưa mô tả'
                          : selectedProduct!['chieu_rong'].toString() + ' (m)'),
                  twoTextBetween(
                      'Diện tích',
                      selectedProduct!['dien_tich'] == null
                          ? 'Chưa mô tả'
                          : selectedProduct!['dien_tich'].toString() + ' (m2)'),
                  twoTextBetween(
                      'Hướng',
                      selectedProduct!['dien_tich'] == null
                          ? 'Chưa mô tả'
                          : selectedProduct!['huong'].toString()),
                  twoTextBetween(
                      'Pháp lý',
                      selectedProduct!['phap_ly'] == null
                          ? 'Chưa mô tả'
                          : selectedProduct!['phap_ly'].toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: customSizedButton('Gọi điện', context,
                              Icons.phone, Colors.green, 10, () {})),
                      Container(
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          child: customSizedButton('Nhắn tin', context,
                              Icons.message, Colors.blue, 10, () {})),
                    ],
                  )
                ]),
              ),
            ),
      body: GoogleMap(
        onTap: _handleOnTap,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        markers: Set.from(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

      //   floatingActionButton: Container(
      //     width: 50,
      //     height: 50,
      //     margin: EdgeInsets.only(right: 40),
      //     decoration: BoxDecoration(
      //       color: Colors.blue,
      //       border: Border.all(color: Colors.white,),
      //       borderRadius: BorderRadius.all(Radius.circular(100)),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.blue,
      //           blurRadius: 3,
      //           spreadRadius: 3,
      //         )
      //       ],
      //     ),
      //     child: TextButton(
      //       onPressed: () async {
      //         final GoogleMapController controller = await _controller.future;
      //         Location loc = Location();
      //         loc.getLocation().then((LocationData data) => ({
      //           if(data.longitude != null && data.latitude != null) {
      //             controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //             target: LatLng(data.latitude!, data.longitude!), zoom: 20)))
      //           }
      //         }));
      //       },
      //       child: Icon(Icons.location_on, color: Colors.white),
      //     ) ,
      //   ),
    );
  }

  void _handleOnTap(LatLng coords) {
    setState(() {
      _markers = [];
      _markers.add(Marker(
          markerId: MarkerId(coords.toString() + '2'),
          position: coords,
          draggable: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(title: 'Chạm để tạo sản phẩm ở vị này ?'),
          onTap: () async {
            var prefs = await SharedPreferences.getInstance();
            await prefs.setString('selectedCoord',
                coords.latitude.toString() + ',' + coords.longitude.toString());
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreateProductScreen()));
          }));
    });
  }

  Widget twoTextBetween(String label, String value) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label + ':',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value,
              style: TextStyle(
                fontSize: 16,
              )),
        ],
      ),
    );
  }
}
