import 'dart:async';
import 'package:canteen_productadd_application/controller/login_controller/login_controller.dart';
import 'package:canteen_productadd_application/view/home/home.dart';
import 'package:canteen_productadd_application/view/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getLog = Get.put(UserLoginController());
  @override
  void initState() {
    print("1");

    super.initState();

    //   Timer(
    //     const Duration(seconds: 3),
    //     () async {
    //       print("splash");
    //       bool status = await getLog.checkLoginStatus();
    //       Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(
    //           builder: (_) => status ? EmployeeHomeScreen() : LoginScreen(),
    //         ),
    //       );
    //     },
    //   );
    // }
    Timer(
      const Duration(seconds: 3),
      () async {
        print("Checking login status...");
        getLog.checkLoginStatus();
        // print("Is logged in? $status");
        final sharedPre = await SharedPreferences.getInstance();
        final status = sharedPre.getBool('isLoggedIn');
        print(status);

        if (status == true) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/albustanwhite.png',
              height: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
