
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserLoginController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Future<void> userLogin() async {
try {
    
    
  await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim()).then((value) => Get.offAll(()=>const HomeScreen()));
} catch (e) {
  print("object");
  return
  showToast(msg: "Invalid");
  
}
  }
}
