import 'package:canteen_productadd_application/model/admin_model/admin_model.dart';

class UserCredentialsController {
  static String? userRole;
  static AdminModel? userModel;

  static void clearUserCredentials() {
    userModel = null;
  }
}
