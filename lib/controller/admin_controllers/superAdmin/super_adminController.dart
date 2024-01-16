import 'dart:developer';
import 'package:canteen_productadd_application/model/admin_model/admin_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SuperAdminController extends GetxController {
  Future createAdmin(
      {required AdminModel userdata,
      required String collectionName,
      required String userRole}) async {
    // fetch signup admin detail ... and creating a Admin with email and password

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userdata.email, password: userdata.password)
          .then((value) async {
        final AdminModel userDetail = AdminModel(
            userrole: userRole,
            docid: value.user!.uid,
            email: userdata.email,
            activate: false,
            imageURl: userdata.imageURl,
            phoneNo: userdata.phoneNo,
            password: userdata.password,
            assignpower: false,
            name: userdata.name);
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(value.user!.uid)
            .set(userDetail.toMap())
            .then((value) async {
          showToast(msg: "Access Approved");
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
