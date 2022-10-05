import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastCuston {
  static void LikeToast(String title) {
    Fluttertoast.showToast(
        //"Felicidades por su nueva cuenta :)"
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void ErrorToast(String title) {
    Fluttertoast.showToast(
        //"Felicidades por su nueva cuenta :)"
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
