import 'package:flutter/material.dart';
import 'util/Sp_util.dart';
import 'main.dart';

class Logout {
  static void logout(context) async {
    if (SpUtil.preferences.containsKey("trip")){
      SpUtil.preferences.setStringList("trip", []);
    }
    SpUtil.preferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new HomeScreen()
        ), (route) => route == null);
  }
}