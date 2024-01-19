import 'dart:developer';

import 'package:canteen_productadd_application/controller/user_getDetails_controller.dart/user_auth_controller.dart';
import 'package:canteen_productadd_application/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginController extends GetxController {
  UserAuthDetailController userAuthController =
      Get.put(UserAuthDetailController());
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool isLoggedIn = false;

  Future<void> userLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then(
        (value) async {
          await userAuthController.fetchUserDetails().then(
                (value) => Get.offAll(
                  () => const HomeScreen(),
                ),
              );
        },
      );
    } catch (e) {
      log(e.toString());
      return showToast(msg: "Invalid");
    }
  }

// <<userLogout>>
  Future<void> userLogout() async {
    print("userLogout");
    FirebaseAuth.instance.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    // isLoggedIn = false;

    print("Logged out successfully");
  }

// <<checkLoginStatus>>
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn')!;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn = false;
  }

  void showToast({required String msg}) {
    print("object");

    print(msg);
  }
}
