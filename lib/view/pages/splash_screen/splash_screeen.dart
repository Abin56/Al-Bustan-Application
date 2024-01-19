import 'package:canteen_productadd_application/model/admin_model/admin_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/home/employee/home.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/shared_pref_helper.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/user_auth/user_credentials.dart';
import 'package:canteen_productadd_application/view/home/storeadmin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/home/super_admin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/pages/login/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    nextpage();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/albustanwhite.png',
              height: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> nextpage() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredentialsController.userRole =
      SharedPreferencesHelper.getString(SharedPreferencesHelper.userRoleKey);
  await Future.delayed(const Duration(seconds: 2));
  if (auth.currentUser == null) {
    Get.offAll(() => LoginScreen());
  } else {
    if (UserCredentialsController.userRole == 'employee') {
      await checkEmployee(auth);
    } else if (UserCredentialsController.userRole == 'deliveryadmin') {
      await checkDeliveryAdmin(auth);
    } else if (UserCredentialsController.userRole == 'warehouseadmin') {
      await checkWhereHouseAdmin(auth);
    } else if (UserCredentialsController.userRole == 'storeadmin') {
      await checkStoreAdmin(auth);
    } else if (UserCredentialsController.userRole == 'superadmin') {
      Get.offAll(() => const SuperAdminNavBar());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}

Future<void> checkEmployee(FirebaseAuth auth) async {
  final employedata = await FirebaseFirestore.instance
      .collection('EmployeeProfile')
      .doc(auth.currentUser?.uid)
      .get();

  if (employedata.data() != null) {
    UserCredentialsController.userModel =
        AdminModel.fromMap(employedata.data()!);
    Get.offAll(() => const EmployeHomeScreen());
  } else {
    showToast(msg: "Please login again");
    Get.offAll(() => LoginScreen());
  }
}

Future<void> checkSuperAdmin(FirebaseAuth auth) async {
  final employedata = await FirebaseFirestore.instance
      .collection('EmployeeProfile')
      .doc(auth.currentUser?.uid)
      .get();

  if (employedata.data() != null) {
    UserCredentialsController.userModel =
        AdminModel.fromMap(employedata.data()!);
    Get.offAll(() => const SuperAdminNavBar());
  } else {
    showToast(msg: "Please login again");
    Get.offAll(() => LoginScreen());
  }
}

Future<void> checkDeliveryAdmin(FirebaseAuth auth) async {
  final employedata = await FirebaseFirestore.instance
      .collection('DeliveryAdmin')
      .doc(auth.currentUser?.uid)
      .get();

  if (employedata.data() != null) {
    UserCredentialsController.userModel =
        AdminModel.fromMap(employedata.data()!);
    Get.offAll(() => const DeliveryAdminNavBar());
  } else {
    showToast(msg: "Please login again");
    Get.offAll(() => LoginScreen());
  }
}

Future<void> checkStoreAdmin(FirebaseAuth auth) async {
  final employedata = await FirebaseFirestore.instance
      .collection('StoreAdmin')
      .doc(auth.currentUser?.uid)
      .get();

  if (employedata.data() != null) {
    UserCredentialsController.userModel =
        AdminModel.fromMap(employedata.data()!);
    Get.offAll(() => const StoreAdminNavBar());
  } else {
    showToast(msg: "Please login again");
    Get.offAll(() => LoginScreen());
  }
}

Future<void> checkWhereHouseAdmin(FirebaseAuth auth) async {
  final employedata = await FirebaseFirestore.instance
      .collection('WarehouseAdmin')
      .doc(auth.currentUser?.uid)
      .get();

  if (employedata.data() != null) {
    UserCredentialsController.userModel =
        AdminModel.fromMap(employedata.data()!);
    Get.offAll(() => WareHouseAdminNavBar());
  } else {
    showToast(msg: "Please login again");
    Get.offAll(() => LoginScreen());
  }
}
