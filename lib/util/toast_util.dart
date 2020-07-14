import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:healthybus_bus/app_theme.dart';
class ToastUtil{
  static void toast(context, String msg) {
    FlutterToast flutterToast = FlutterToast(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color.fromARGB(255, 215, 224, 249),//Colors.black12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Icon(Icons.check),
          //SizedBox(
          //width: 12.0,
          //),
          Text(msg, style: new TextStyle(color: AppTheme.nearlyDarkBlue.withOpacity(0.8)),)
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 1),
    );
  }
}