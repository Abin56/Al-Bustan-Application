import 'package:canteen_productadd_application/view/home/home.dart';
import 'package:canteen_productadd_application/view/login/loginScreen.dart';
import 'package:canteen_productadd_application/view/shared_pref/shared_pref_helper.dart';
import 'package:canteen_productadd_application/view/shared_pref/user_auth/user_credentials.dart';
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
    Get.offAll(() => const HomeScreen());
  }
}
