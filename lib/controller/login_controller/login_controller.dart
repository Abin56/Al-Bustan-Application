import 'dart:developer';

import 'package:canteen_productadd_application/controller/user_getDetails_controller.dart/user_auth_controller.dart';
import 'package:canteen_productadd_application/model/admin_model/admin_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/home/employee/home.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/shared_pref_helper.dart';
import 'package:canteen_productadd_application/view/home/storeadmin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/navbar/navbar.dart';
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
  Future<void> employeeLogin(BuildContext context) async {
    try {
      isLoading.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(value.user?.uid)
            .get();
        if (user.data() != null) {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'employee');
          isLoading.value = false;
          emailcontroller.clear();
          passwordcontroller.clear();
          Get.off(() => const EmployeHomeScreen());
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

  Future<void> storeAdminLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      )
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(value.user?.uid)
            .get();
        if (user.data() != null) {
          final datsa = UserCredentialsController.adminmodel =
              AdminModel.fromMap(user.data()!);
          log("adminmodel$datsa");
        }
        if (UserCredentialsController.adminmodel?.userrole == "storeadmin") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'storeadmin');
          isLoading.value = false;
          emailcontroller.clear();
          passwordcontroller.clear();
          Get.offAll(() => const StoreAdminNavBar());
        } else {
          showToast(msg: "You are not a StoreAdmin");
          isLoading.value = false;
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }

  Future<void> deliveryAdminLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      )
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(value.user?.uid)
            .get();
        if (user.data() != null) {
          final datsa = UserCredentialsController.adminmodel =
              AdminModel.fromMap(user.data()!);
          log("adminmodel$datsa");
        }
        if (UserCredentialsController.adminmodel?.userrole == "deliveryadmin") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'deliveryadmin');
          isLoading.value = false;
          emailcontroller.clear();
          passwordcontroller.clear();
          Get.off(() => const DeliveryAdminNavBar());
        } else {
          showToast(msg: "You are not a DeliveryAdmin");
          isLoading.value = false;
        }
      }).catchError((error) {
        log(error.toString());
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }

  Future<void> wareHouseAdminLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      )
          .then((value) async {
        final user = await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(value.user?.uid)
            .get();
        if (user.data() != null) {
          final datsa = UserCredentialsController.adminmodel =
              AdminModel.fromMap(user.data()!);
          log("adminmodel$datsa");
        }
        if (UserCredentialsController.adminmodel?.userrole ==
            "warehouseadmin") {
          await SharedPreferencesHelper.setString(
              SharedPreferencesHelper.userRoleKey, 'warehouseadmin');
          isLoading.value = false;
          emailcontroller.clear();
          passwordcontroller.clear();
          Get.off(() =>  WareHouseAdminNavBar());
        } else {
          showToast(msg: "You are not a WarehouseAdmin");
          isLoading.value = false;
        }
      }).catchError((error) {
        if (error is FirebaseAuthException) {
          isLoading.value = false;
          handleFirebaseError(error);
        }
      });
    } catch (e) {
      isLoading.value = false;
      // showToast(msg: e.toString());
      showToast(msg: "Sign in failed");
    }
  }
}
