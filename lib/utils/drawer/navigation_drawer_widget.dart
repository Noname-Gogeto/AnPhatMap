// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rcore/utils/dialogs/dialog.dart';
import '../../views/landing/login_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  final List<Widget>? listPage;
  const NavigationDrawerWidget({
    Key? key,
    this.listPage,
  }) : super(key: key);

  static const assetsImagePath = 'lib/assets/images/main-logo.png';
  static const userName = 'Admin';
  static const userEmail = 'Hihi123@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 248, 248, 248),
        child: ListView(
          children: [
            buildHeader(context),
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
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Map',
                    icon: Icons.pin_drop_outlined,
                    onClicked: () => selectedItem(context, 1),
                  ),

                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Sản phẩm',
                    icon: Icons.production_quantity_limits_rounded,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 15),
                  buildMenuItem(
                    text: 'Thành viên',
                    icon: Icons.people_alt_outlined,
                    onClicked: () => selectedItem(context, 4),
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
    return InkWell(
      onTap: () => selectedItem(context, 2),
      child: Container(
        color: Colors.blue.shade400,
        // color: themeColor,
        padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: AssetImage(urlImage)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
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

  Widget buildMenuItem({
    String text = 'This is a title menu',
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const baseColor = Colors.black;
    Color hoverColor = Colors.blue.shade100;

    return ListTile(
      leading: Icon(icon, color: baseColor),
      title: Text(text, style: const TextStyle(color: baseColor)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    try {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        // ignore: prefer_const_constructors
        builder: (context) => listPage![index],
      ));
    } catch (e) {
      print(e.toString());
    }
  }
}
