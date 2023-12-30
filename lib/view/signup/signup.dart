import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/controller/create_profileController/create_profile_controller.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/login/loginScreen.dart';
import 'package:canteen_productadd_application/view/login/widgets/loginbutton.dart';
import 'package:canteen_productadd_application/view/signup/circle_avatar_widget.dart';
import 'package:canteen_productadd_application/view/widgets/isLoadin_showDilogue/isaLoading_diloguebox.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  final CreateProfileController createProfileController =
      Get.put(CreateProfileController());
  SignUpPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: GooglePoppinsWidgets(
                    fontsize: 40,
                    text: 'SignUp',
                    color: cBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircleAvatharImageSelectionWidget(),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormFiledContainerWidget(
                        controller: createProfileController.nameController,
                        hintText: " Enter your name",
                        title: 'Name',
                        width: 300,
                        validator: checkFieldEmpty,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextFormFiledContainerWidget(
                          controller: createProfileController.phonenoController,
                          hintText: " Enter your phone no",
                          title: 'Phone No',
                          width: 300,
                          keyboardType: TextInputType.number,
                          validator: checkFieldEmpty,
                        ),
                      ),
                      TextFormFiledContainerWidget(
                          controller: createProfileController.emailController,
                          hintText: " Enter your email id",
                          title: 'Email',
                          width: 300,
                          validator: checkFieldEmailIsValid),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: TextFormFiledContainerWidget(
                          controller:
                              createProfileController.passwordController,
                          hintText: " Enter your password",
                          title: 'Password',
                          width: 300,
                          validator: checkFieldPasswordIsValid,
                        ),
                      ),
                      TextFormFiledContainerWidget(
                        controller: createProfileController.conformController,
                        hintText: " Enter your confirm password",
                        title: 'Confirm password',
                        width: 300,
                        validator: checkFieldPasswordIsValid,
                      ),
                      Obx(() => createProfileController.isLoading.value == true
                          ? const LoadingLottieWidget(height: 100, width: 200)
                          : Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (createProfileController
                                            .employeeImagePath.value ==
                                        null) {
                                      showToast(
                                          msg: 'Please upload your image');
                                    } else if (createProfileController
                                            .passwordController.text ==
                                        createProfileController
                                            .conformController.text) {
                                      createProfileController.isLoading.value =
                                          true;
                                      await createProfileController
                                          .uploadImageFirebaseStore(
                                              createProfileController
                                                  .employeeImagePath.value!)
                                          .then((value) async {
                                        await createProfileController
                                            .addEmployeeDetailsToServer();
                                      });
                                    }else{
                                           return showToast(
                                            msg: 'Password missmatch');
                                    }
                                  }
                                },
                                child: loginButtonWidget(
                                  height: 50,
                                  width: 240,
                                  text: 'Submit',
                                ),
                              ),
                            )),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
