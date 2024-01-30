import 'package:canteen_productadd_application/model/notification_model/notification_model.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NotificationListController extends GetxController {
  final firebase = dataserver.collection("Notification_Collection");

  Future newUserSentNotification(NotificationModel datamodel) async {
    final uuid = const Uuid().v1();
    await firebase.doc(uuid).set(datamodel.toMap());
  }
}
