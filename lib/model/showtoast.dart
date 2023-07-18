import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// debug용
void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM);
}

// 알림용
void showToastNotification(String message) {
  Fluttertoast.showToast(
      msg: message,
      fontSize: 15,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP);
}
