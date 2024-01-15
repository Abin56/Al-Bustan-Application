import 'dart:developer';

import 'package:canteen_productadd_application/controller/user_getDetails_controller.dart/user_auth_controller.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/home/home.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/shared_pref_helper.dart';
import 'package:canteen_productadd_application/view/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  RxBool isLoading = RxBool(false);
  UserAuthDetailController userAuthController =
      Get.put(UserAuthDetailController());
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Future<void> userLogin(BuildContext context) async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('EmployeeProfile')
            .doc(value.user?.uid)
            .get();
        if (user.data() != null) {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'employee');
          isLoading.value = false;

          Get.off(() => const HomeScreen());
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
          log("firebase Eror$error");
        }
      });
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }
}
