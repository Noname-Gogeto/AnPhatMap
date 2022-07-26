// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print, prefer_if_null_operators, prefer_collection_literals, unnecessary_new, avoid_unnecessary_containers, await_only_futures, prefer_is_empty, unnecessary_null_comparison, empty_catches, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rcore/utils/color/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:rcore/utils/dialogs/dialog.dart';

/// It's a function that sends a request to the server and returns the response
///
/// Args:
///   link (String): the link to the API
///   context (BuildContext): The context of the current screen
///   method (String): POST
///   params (Map<String, dynamic>): {
///
/// Returns:
///   A Future<Map<String, dynamic>?>
Future<Map<String, dynamic>?> GetAPI(String link, BuildContext context,
    String method, Map<String, dynamic> params) async {
  try {
    // List<String> param = List<String>.generate(0, (index) => "");
    // if(params.length > 0) {
    //   params.forEach((key, value) {
    //     param.add(key.toString() + "=" + value.toString());
    //   });
    //   link = link + "?" + param.join("&");
    // }
    print("Getting data from: " + link);
    // final http.Request request = http.Request(method, Uri.parse(link));
    // final http.StreamedResponse response = await http.Client().send(request);
    // String responseData =  await response.stream.transform(utf8.decoder).join();
    http.Response response = new http.Response(jsonEncode({}), 401);
    switch (method) {
      case 'POST':
        print(jsonEncode(params).toString());
        response = await http.post(
          Uri.parse(link),
          body: params,
        );
    }
    Map<String, dynamic> jsonData = new Map();
    try {
      jsonData = json.decode(response.body);
    } catch (e) {
      List<dynamic> list = json.decode(response.body);
      int i = 0;
      for (var item in list) {
        jsonData[i.toString()] = item == null ? "" : item;
        i++;
      }
    }
    print(jsonData);
    if (response.statusCode != 200) {
      notiDialog('LỖI', jsonData['message'], () {
        Navigator.pop(context);
      }, context);
      return null;
    }
    return jsonData;
  } catch (e) {
    Clipboard.setData(ClipboardData(text: e.toString()));
    notiDialog('LỖI', e.toString(), () {
      Navigator.pop(context);
    }, context);
  }
  return null;
}

/// It takes a message and a context as parameters, and returns a dialog box with the message as the
/// content
///
/// Args:
///   message (String): The message you want to display in the notification.
///   context (BuildContext): The context of the screen you want to show the dialog on.
///
/// Returns:
///   A Future<void>
Future<void> ShowNotification(String message, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Notification'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(message,
                  style: TextStyle(
                    fontSize: 18,
                  )),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Confirm', style: TextStyle(color: themeColor)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

/// It takes a list of widgets, a title, a context, and a storage object, and then it displays a modal
/// with the widgets, title, and context, and then it returns the result of the modal to the storage
/// object
///
/// Args:
///   widgets (List<Widget>): A list of widgets to be displayed in the modal.
///   title (String): The title of the modal
///   context (BuildContext): The context of the widget that calls the function
///   storage (SharedPreferences): SharedPreferences object
Future<void> showModalSelection(List<Widget> widgets, String title,
    BuildContext context, SharedPreferences storage) async {
  final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Container(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(90, 85, 202, 1),
                              decoration: TextDecoration.none),
                        ),
                      ),
                      Expanded(
                          child: Scrollbar(
                              child: ListView(
                        children: widgets,
                      ))),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close",
                              style: TextStyle(
                                fontSize: 18,
                              )))
                    ],
                  ),
                ),
              )));
  await storage.setString('selectionResult', '$result');
  print('$result');
  print(storage.getString('selectionResult'));
}

Future<void> saveToFile(String key, String value, BuildContext context) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/3.dat';
    final file = File(path);
    if (file.existsSync()) {
      final String data = await file.readAsString();
      Map<String, dynamic> json = jsonDecode(data);
      json[key] = value;
      print(jsonEncode(json));
      file.writeAsString(jsonEncode(json));
    } else {
      Map<String, dynamic> json = new Map();
      json[key] = value;
      print(jsonEncode(json));
      file.writeAsString(jsonEncode(json));
    }
  } catch (e) {
    ShowNotification(e.toString(), context);
  }
}

Future<String> getFromFile(String key, BuildContext context) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/3.dat';
    final file = File(path);
    final String data = await file.readAsString();
    print(data);
    Map<String, dynamic> json = jsonDecode(data);
    return json[key];
  } catch (e) {
    return "";
  }
}

Future<void> deleteFile(BuildContext context) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/3.dat';
    final file = File(path);
    await file.delete();
  } catch (e) {}
}

void SaveTempJSON(Map<String, dynamic> json) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString('tempJSON', jsonEncode(json));
}

String getToken(String username) {
  print(DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now()));

  return md5
      .convert(utf8.encode(md5.convert(utf8.encode(username)).toString() +
          'ANDIN' +
          DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())))
      .toString();
}

Future<String> getUID() async {
  var prefs = await SharedPreferences.getInstance();
  String? res = await prefs.getString('uid');
  return res == null ? "" : res;
}

Future<String> getUsername() async {
  var prefs = await SharedPreferences.getInstance();
  String? res = await prefs.getString('username');
  return res == null ? "" : res;
}

Future<String> getAuthKey() async {
  var prefs = await SharedPreferences.getInstance();
  String? res = await prefs.getString('auth_key');
  return res == null ? "" : res;
}

Future<Map<String, dynamic>> getUserInfo() async {
  var prefs = await SharedPreferences.getInstance();
  String? res = await prefs.getString('userInfo');
  return jsonDecode(res!);
}
