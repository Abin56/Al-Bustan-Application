import 'dart:convert';
import 'dart:developer';

import 'package:canteen_productadd_application/controller/push_notification/notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
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
    print("user permission");
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

  
  Future<void> sendPushMessage(String body, String title) async {
    log("Send Push Message");
      try {
        final reponse = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAxbdckj0:APA91bHeFNsJ_6Pfo69P9sJz_0JfZeOxV6gB6DectpcZEleEyY-CUCY21PuktRYlXVXvrvHK_XRrZdN4-DcNHL2nmPgEISL73AkNnVGbhmjRsiiX0aVb4P9iJH5RqZKdroBQLjCsOwAr'
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": <String, dynamic>{
                'title': title,
                'body': body,
                'android_channel_id': 'high_importance_channel'
              },
              'to':'cfOlJFO5QDG6lDR59h8Z_f:APA91bEND0RR1jKfybAOuCcPLM92YoSOWp_eRnQZQiJ7Supmh9AEYZRvpDF9BKXM-bVDUASTlYSwu4Ss9owUncrjkFtUL0ROigupDtoP54upz2r1OYNlLHb7H_dTZvqt0xT843Qm-Iee',
            },
          ),
        );
        log("response --L>>  ${reponse.body}");
      } catch (e) {
        if (kDebugMode) {
          log("error push Notification");
        }
      }
   

 
  }


}