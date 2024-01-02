import 'dart:async';
import 'package:canteen_productadd_application/controller/login_controller.dart';
import 'package:canteen_productadd_application/view/homescreen/homescreen.dart';
import 'package:canteen_productadd_application/view/login/loginScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController loginController = LoginController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    await loginController.checkLoginStatus();
    Timer(
      const Duration(seconds: 3),
      () {
        print("if");
        if (loginController.isLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const EmployeeHomeScreen(),
            ),
          );
        } else {
          print("else");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ),
          );
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
