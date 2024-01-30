import 'package:canteen_productadd_application/model/admin_model/admin_model.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/shared_pref_helper.dart';
import 'package:canteen_productadd_application/view/pages/splash_screen/splash_screeen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserCredentialsController {
  static String? userRole;
  static AdminModel? userModel;

  static void clearUserCredentials() {
    userModel = null;
  }
}

logoutUser() async {
  await FirebaseAuth.instance.signOut().then((value) async {
    await SharedPreferencesHelper.clearSharedPreferenceData();
    UserCredentialsController.clearUserCredentials();
    Get.offAll(const SplashScreen());
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  });
}
