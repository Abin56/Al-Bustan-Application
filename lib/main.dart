import 'package:canteen_productadd_application/firebase_options.dart';
import 'package:canteen_productadd_application/view/core/shared_pref/shared_pref_helper.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/delivery_management/precheck_orders/precheck_order.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseAppCheck.instance
  //     .activate(
  //   androidProvider: AndroidProvider.debug,
  // )
  //     .catchError((e) {
  //   log(e.toString());
  // });

  // await FirebaseAppCheck.instance.getToken().catchError((e) {
  //   print(e.toString());
  // });
  await SharedPreferencesHelper.initPrefs();
  runApp(const MyApp());
  // log("result....................... $result");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //  home:
// DeliveryAdminNavBar (),
      //  SuperAdminNavBar(),
      // NavigationBarPage(),
      home: PreCheckordersScreen(),
    );
  }
}
