import 'package:flutter/material.dart';
import 'package:rcore/views/layouts/layout2.dart';

class ProfileScreenHihi extends StatefulWidget {
  ProfileScreenHihi({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<ProfileScreenHihi> createState() => _ProfileScreenHihiState();
}

class _ProfileScreenHihiState extends State<ProfileScreenHihi> {
  Map<String, dynamic> userInfo = {'hihi': 'x'};
  @override
  Widget build(BuildContext context) {
    return layout2(
        widget._scaffoldKey, context, 'hiihi', [], 'permission', userInfo);
  }
}
