import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/navbar/navbar.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/navbar/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WareHouseHomeScreen extends StatelessWidget {
  const WareHouseHomeScreen({super.key});

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
                return WareHouseAdminNavBar();
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
