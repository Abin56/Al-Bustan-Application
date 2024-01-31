import 'dart:developer';

import 'package:canteen_productadd_application/controller/push_notification/notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PushNotificationController extends GetxController {
  @override
  void onReady() {
    userRequestPermission(); //user notification permission
    getDeviceToken(); // Get User Current Device token
    notificationServices.firebaseInit();
    notificationServices.setupInteractMessage();
    super.onReady();
  }

  NotificationServices notificationServices = NotificationServices();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String deviceToken = '';
  void userRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  void getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token ?? 'Not get the token ';
      log("User Device Token :: $token");

      saveDeviceTokenToFireBase(deviceToken);
    });
  }

  void saveDeviceTokenToFireBase(String deviceToken) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("UserDeviceToken").doc(uid).set({
      'deviceToken': deviceToken,
      'uid': uid
    }).then((value) => log(
        'Device Token Saved To FIREBASE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'));
  }


}