import 'package:canteen_productadd_application/controller/push_notification/push_notification.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/user_auth/user_credentials.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/pages/login/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DeliveryHomeScreen extends StatelessWidget {
  
 DeliveryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('AllUsersCollection')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snap) {
            if (snap.hasData) {
              if (snap.data!.data()!['activate'] == true) {
                if (snap.data!.data()!['userrole'] == '') {
                  logoutUser();
                  return LoginScreen();
                } else {
                  return  DeliveryAdminNavBar();
                }
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 400,
                        child: LottieBuilder.asset('images/NO ACCESS.json')),
                    GoogleMonstserratWidgets(
                      text: "Waiting for Admin Approval",
                      fontsize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                );
              }
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 400,
                      child: LottieBuilder.asset('images/NO ACCESS.json')),
                  GoogleMonstserratWidgets(
                    text: "Waiting for Admin Approval",
                    fontsize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ],
              );
            }
          }),
    );
  }
}
