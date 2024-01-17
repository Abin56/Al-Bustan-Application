import 'dart:developer';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAuthDetailController extends GetxController {
  RxString userName = ''.obs;
  RxString userPhoneNo = ''.obs;
  TextEditingController editNameController = TextEditingController();
   TextEditingController editPhoneNoController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance.currentUser;

  Future<void> fetchUserDetails() async {
    final firebaseCollection = await FirebaseFirestore.instance
        .collection('EmployeeProfile')
        .doc(firebaseAuth!.uid)
        .get();

    if (firebaseCollection.data() != null) {
      userName.value = firebaseCollection.data()!['name'];
      userPhoneNo.value = firebaseCollection.data()!['phoneNo'];
      log("User Name :::${userName.value}");
      log("User Phone :::${userPhoneNo.value}");
    } else {
      log("Not found user docid");
    }
  }

 Future<void> editNameUserShowDetails()async{
   FirebaseFirestore.instance
  .collection("EmployeeProfile")
  .doc(firebaseAuth!.uid)
  .update({'name':editNameController.text}
  ).then((value) => showToast(msg: "Updated"));
  editNameController.clear();
 }

  Future<void> editPhoneUserShowDetails()async{
   FirebaseFirestore.instance
  .collection("EmployeeProfile")
  .doc(firebaseAuth!.uid)
  .update({'phoneNo':editPhoneNoController.text}
  ).then((value) => showToast(msg: 'Updated'));
  editPhoneNoController.clear();
 }
 
}
