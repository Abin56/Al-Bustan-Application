import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

const circularPIndicator = Center(
  child: CircularProgressIndicator(),
);
void showToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

printLog(String msg) {
  return
  log(msg);
}

dateConveter(DateTime date) {
  String formattedDate = DateFormat('dd-MM-yyyy').format(date);
  return formattedDate;
}
