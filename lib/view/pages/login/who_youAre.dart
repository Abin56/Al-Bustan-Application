import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/pages/login/widgets/user_avathar_widget.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:canteen_productadd_application/controller/login_controller/login_controller.dart';

Future<void> whoAreYou(context) async {
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
                  LoginContainerWidget(
                      onTap: () async {
                        // await Get.find<UserLoginController>().storeAdminLogin();
                      },
                      text: 'Super Admin',
                      imagepath: 'images/super_Admin.jpg',
                      value: 'superadmin'),
                  LoginContainerWidget(
                      onTap: () async {
                        await Get.find<UserLoginController>()
                            .wareHouseAdminLogin();
                      },
                      text: 'WareHouse\n    Admin',
                      imagepath: 'images/warehouse_Admin.jpg',
                      value: 'warehouseadmin'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonContainerWidget(
                      fontWeight: FontWeight.bold,
                      text: "EMPLOYEE",
                      width: 150,
                      height: 40,
                      fontSize: 12,
                      onTap: () async {
                        await Get.find<UserLoginController>()
                            .employeeLogin(context);
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LoginContainerWidget(
                      onTap: () async {
                        await Get.find<UserLoginController>().storeAdminLogin();
                      },
                      text: 'Store Admin',
                      imagepath: 'images/store_Admin.jpg',
                      value: 'storeadmin'),
                  LoginContainerWidget(
                      onTap: () async {
                        await Get.find<UserLoginController>()
                            .deliveryAdminLogin();
                      },
                      text: 'Delivery Admin',
                      imagepath: 'images/delivery_admin.jpg',
                      value: 'deliveryadmin')
                ],
              )
            ],
          ),
        );
      });
}
