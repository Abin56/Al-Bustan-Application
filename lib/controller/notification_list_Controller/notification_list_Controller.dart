import 'package:canteen_productadd_application/model/notification_model/notification_model.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NotificationListController extends GetxController {
  final firebase = dataserver.collection("Notification_Collection");

  Future newUserSentNotification() async {
    final details = NotificationModel(
        icon: Icons.warning_rounded,
        messageText: "New User Founded",
        headerText: "INFO",
        whiteshadeColor: InfoNotification().whiteshadeColor,
        containerColor: InfoNotification().containerColor);
    final uuid = const Uuid().v1();
    await firebase.doc(uuid).set(details.toMap());
  }
}

class WaringNotification {
  Color whiteshadeColor = const Color.fromARGB(255, 241, 134, 120);
  Color containerColor = const Color.fromARGB(255, 237, 95, 75);
  IconData icon = Icons.warning_rounded;
}

class InfoNotification {
  Color whiteshadeColor = const Color.fromARGB(255, 63, 162, 232);
  Color containerColor = const Color.fromARGB(255, 4, 130, 225);
  IconData icon = Icons.warning_rounded;
}

class SuccessNotification {
  Color whiteshadeColor = const Color.fromARGB(255, 127, 203, 153);
  Color containerColor = const Color.fromARGB(255, 84, 187, 119);
  IconData icon = Icons.warning_rounded;
}
