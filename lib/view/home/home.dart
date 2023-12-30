import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('EmployeeProfile').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context,snap) {
        
          
       if (snap.hasData) {
        
      
        if (snap.data!.data()!['activate']==true) {
              return const Center(
            child: Text("ACCESS ON"),
          );
          
        }else{
          return Center(child: LottieBuilder.asset('images/NO ACCESS.json'),);
        }
        
         
       }else{
                return Center(child: LottieBuilder.asset('images/NO ACCESS.json'),);
       }
        }
      ),
    );
  }
}