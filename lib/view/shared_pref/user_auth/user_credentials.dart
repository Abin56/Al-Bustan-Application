import 'package:canteen_productadd_application/model/user_model/user_model.dart';

class UserCredentialsController {
   static String? userRole;
  static UserAuthModel? userModel;

  static void clearUserCredentials() {
    userModel = null;
  }
}
