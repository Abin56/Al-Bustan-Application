import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserAuthDetailController extends GetxController {
  RxString userName = ''.obs;
  RxString userPhoneNo = ''.obs;
  final firebaseAuth = FirebaseAuth.instance.currentUser;

  Future<void> fetchUserDetails() async {
    final firebaseCollection = await FirebaseFirestore.instance
        .collection('AllUsersCollection')
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
}
