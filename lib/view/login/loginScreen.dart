import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/controller/login_controller/login_controller.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/login/forgetPassword/forgetPassword.dart';
import 'package:canteen_productadd_application/view/login/widgets/containerwidget.dart';
import 'package:canteen_productadd_application/view/login/widgets/loginbutton.dart';

import 'package:canteen_productadd_application/view/signup/signup.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final int? pageIndex;

  LoginScreen({this.pageIndex, super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserLoginController userlogincontroller =
      Get.put(UserLoginController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/albustanblack.png"))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GooglePoppinsWidgets(
                      text: 'ALBUSTAN',
                      fontsize: 15,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    ),
                    GooglePoppinsWidgets(
                      text: 'BAKERY N SWEETS',
                      fontsize: 15,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: cWhite,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ContainerImage(
                    height: 340,
                    width: double.infinity,
                    imagePath: 'images/Al_bustan.jpg'),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 210, bottom: 20),
                        child: GooglePoppinsWidgets(
                          fontsize: 40,
                          text: 'Login',
                          color: cBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormFiledContainerWidget(
                          hintText: " Enter your email id",
                          title: 'Email id',
                          controller: userlogincontroller.emailcontroller,
                          width: 300,
                          validator: checkFieldEmailIsValid),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormFiledContainerWidget(
                          hintText: " Enter your password",
                          title: 'Password',
                          controller: userlogincontroller.passwordcontroller,
                          width: 300,
                          validator: checkFieldPasswordIsValid,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 210),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: GooglePoppinsWidgets(
                              fontsize: 12,
                              text: 'Forgot Password?',
                              fontWeight: FontWeight.w400,
                              color: themeColorBlue,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await userlogincontroller.userLogin();
                              } else {}
                            },
                            child: loginButtonWidget(
                              height: 50,
                              width: 240,
                              text: 'Login',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GooglePoppinsWidgets(
                              text: "Don't have an account?",
                              fontsize: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              },
                              child: GooglePoppinsWidgets(
                                text: '  Sign Up',
                                fontsize: 18,
                                color: cBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
