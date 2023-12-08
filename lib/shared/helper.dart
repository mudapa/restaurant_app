import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'style.dart';

void toast(String message, Color color) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: color,
    textColor: whiteColor,
    fontSize: 16,
  );
}
