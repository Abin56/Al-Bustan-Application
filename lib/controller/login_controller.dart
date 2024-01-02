import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LoginController extends GetxController {
//   final emailcontroller = TextEditingController();
//   final passwordcontroller = TextEditingController();

//   RxBool isLoggedIn = false.obs;

//   Future<void> userLogin() async {
//     bool loginSuccessful = true;

//     if (loginSuccessful) {
//       print("loginSuccessful");
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       isLoggedIn.value = true;
//       print("loginSuccessful >>> true");
//     }
//   }

//   Future<void> userLogout() async {
//     print("userLogout");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', false);
//     isLoggedIn.value = false;
//     print("loginSuccessful >>> false");
//   }

//   Future<void> checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
//   }
// }

class LoginController {
  final TextEditingController eemailController = TextEditingController();
  final TextEditingController ppasswordController = TextEditingController();

  bool isLoggedIn = false;

  Future<void> userLogin() async {
    bool loginSuccessful = true;

    if (loginSuccessful) {
      print("loginSuccessful");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      isLoggedIn = true;
      print("loginSuccessful >>> true");
    }
  }

  Future<void> userLogout() async {
    print("userLogout");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn = false;
    print("loginSuccessful >>> false");
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  void dispose() {
    eemailController.dispose();
    ppasswordController.dispose();
  }
}
