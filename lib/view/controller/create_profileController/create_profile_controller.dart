import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/home/home.dart';
import 'package:canteen_productadd_application/view/model/employe_createProfile/employe_createprofile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  Rxn<File> employeeImagePath = Rxn();
  RxBool isLoading = false.obs;
  String downloadURL = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformController = TextEditingController();

  final firebase = FirebaseFirestore.instance.collection("EmployeeProfile");
  final firebaseStorage = FirebaseStorage.instance;

  Future uploadImageFirebaseStore(File imageFile) async {
    final imageName = 'image_${DateTime.now()}.jpg';

    Reference storageRef =
        firebaseStorage.ref().child('EmployeeImageCollection/$imageName');
    try {
      log("imagepath $imageFile");
      final Uint8List imageBytes = await imageFile.readAsBytes();
      await storageRef.putData(imageBytes).whenComplete(() async {
        String url = await storageRef.getDownloadURL();
        downloadURL = url;
        if (kDebugMode) {
          log("URL  :: $downloadURL");
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> addEmployeeDetailsToServer() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((value) async {
      final userDetails = EmployeeProfileCreateModel(
        activate: false,
          docid: value.user!.uid,
          name: nameController.text,
          email: emailController.text.trim(),
          phoneNo: phonenoController.text,
          imageURl: downloadURL);

      await firebase
          .doc(value.user!.uid)
          .set(userDetails.toMap())
          .then((value) async {
        isLoading.value = false;
        nameController.clear();
        passwordController.clear();
        conformController.clear();
        emailController.clear();
        phonenoController.clear();
        employeeImagePath.value = null;
        showToast(msg: "Profile created successfully");
        Get.offAll(()=>const HomeScreen());
      });
    });
  }

}
