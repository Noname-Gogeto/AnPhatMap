// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import '../../views/customers/customers_screen.dart';
import '../../views/employee/employee_screen.dart';
import '../../views/landing/login_screen.dart';
import '../../views/map/map_screen.dart';
import '../../views/products/products_list_screen.dart';
import '../../views/profile/profile_screens.dart';
import '../color/theme.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final Map<String, dynamic>? userInfo;
  NavigationDrawerWidget({
    Key? key,
    this.userInfo,
  }) : super(key: key);

  List<Widget> listPage = [
    CustomerScreen(),
    MapScreen(),
    ProfileScreen(),
    ProductsListScreen(),
    EmployeeListScreen(),
  ];

  static const assetsImagePath = 'lib/assets/images/main-logo.png';
  static const userName = 'Admin';
  static const userEmail = 'Hihi123@gmail.com';
  static String activeName = 'customer';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 248, 248, 248),
        child: ListView(
          children: [
            buildHeader(context,
                userName: userInfo!['username'].toString(),
                userEmail: userInfo!['email'].toString()),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const SizedBox(height: 24),
                  const Divider(color: Colors.black87),
                  buildMenuItem(
                    text: 'Khách hàng',
                    icon: Icons.people,
                    // onClicked: () => Navigator.of(context).pop(),
                    onClicked: () {
                      selectedItem(context, 0);
                      activeName = 'customer';
                    },
                    active: activeName == 'customer',
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Map',
                    icon: Icons.pin_drop_outlined,
                    onClicked: () {
                      selectedItem(context, 1);
                      activeName = 'map';
                    },
                    active: activeName == 'map',
                  ),

                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Sản phẩm',
                    icon: Icons.production_quantity_limits_rounded,
                    onClicked: () {
                      selectedItem(context, 3);
                      activeName = 'product';
                    },
                    active: activeName == 'product',
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Thành viên',
                    icon: Icons.people_alt_outlined,
                    onClicked: () {
                      selectedItem(context, 4);
                      activeName = 'employee';
                    },
                    active: activeName == 'employee',
                  ),
                  const Divider(color: Colors.black87),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Thông báo',
                    icon: Icons.notifications_active,
                    // onClicked: () => selectedItem(context, 3),
                    onClicked: () {},
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Cài đặt',
                    icon: Icons.settings,
                    // onClicked: () => selectedItem(context, 4),
                    onClicked: () {},
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Giới thiệu',
                    icon: Icons.info,
                    // onClicked: () => selectedItem(context, 5),
                    onClicked: () {},
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Đăng xuất',
                    icon: Icons.logout_rounded,
                    onClicked: () {
                      yesNoDialog('Thông báo', 'Bạn có muốn đăng xuất không?',
                          () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      }, () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }, context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context,
      {String urlImage = assetsImagePath,
      String userName = userName,
      String userEmail = userEmail}) {
    return Container(
      padding: padding.add(const EdgeInsets.symmetric(vertical: 35)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        image: DecorationImage(
            image: AssetImage('lib/assets/images/product-demo.jpg'),
            fit: BoxFit.cover),
        color: Color.fromRGBO(255, 255, 255, 0.7),
      ),
      child: TextButton(
        onPressed: () => selectedItem(context, 2),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: AssetImage(urlImage)),
            const SizedBox(width: 20),
            Container(
              height: 80,
              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userEmail,
                      style: const TextStyle(
                        fontSize: 15,
                        color: themeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // const CircleAvatar(
            //   radius: 24,
            //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
            //   child: Icon(
            //     Icons.add_comment_outlined,
            //     color: Colors.white,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {String text = 'This is a title menu',
      required IconData icon,
      VoidCallback? onClicked,
      bool active = false}) {
    const baseColor = Colors.black;
    Color hoverColor = Colors.blue.shade400;

    return ListTile(
      leading: Icon(icon, color: active ? themeColor : baseColor),
      title:
          Text(text, style: TextStyle(color: active ? themeColor : baseColor)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    try {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => listPage[index],
      ));
    } catch (e) {
      print(e.toString());
    }
  }
}
