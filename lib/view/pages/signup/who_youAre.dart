import 'package:canteen_productadd_application/controller/create_profileController/create_profile_controller.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';

import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> whoAreYouSignUp(context) async {
  final CreateProfileController createProfileController =
      Get.put(CreateProfileController());
  return showModalBottomSheet(
      backgroundColor: cWhite,
      context: context,
      builder: (builder) {
        return SizedBox(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonContainerWidget(
                      fontWeight: FontWeight.bold,
                      text: "STORE ADMIN",
                      width: 150,
                      height: 40,
                      fontSize: 12,
                      onTap: () async {
                        await createProfileController
                            .addStoreAdminDetailsToServer();
                      }),
                  ButtonContainerWidget(
                      fontWeight: FontWeight.bold,
                      text: "DELIVERY ADMIN",
                      width: 150,
                      height: 40,
                      fontSize: 12,
                      onTap: () async {
                        await createProfileController
                            .addDeliveryAdminDetailsToServer();
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonContainerWidget(
                      fontWeight: FontWeight.bold,
                      text: "EMPLOYEE",
                      width: 150,
                      height: 40,
                      fontSize: 12,
                      onTap: () async {
                        await createProfileController
                            .addEmployeeDetailsToServer();
                      }),
                  ButtonContainerWidget(
                      fontWeight: FontWeight.bold,
                      text: "WAREHOUSE ADMIN",
                      width: 150,
                      height: 40,
                      fontSize: 12,
                      onTap: () async {
                        await createProfileController
                            .addWarewHouseAdminDetailsToServer();
                      })
                ],
              )
            ],
          ),
        );
      });
}
