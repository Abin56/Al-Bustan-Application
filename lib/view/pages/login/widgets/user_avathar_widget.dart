// ignore_for_file: must_be_immutable

import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class LoginContainerWidget extends StatelessWidget {
  final String value;
  final String imagepath;
  void Function()? onTap;
  LoginContainerWidget({
    required this.onTap,
    required this.text,
    super.key,
    required this.imagepath,
    required this.value,
  });
  String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            color: cWhite,
            shape: BoxShape.circle,
            border: Border.all(color: cGrey.withOpacity(0.5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: cWhite,
                radius: 30,
                child: Image.asset(imagepath),
              ),
              // const CircleAvatar(
              //   radius: 100,
              //   backgroundImage: AssetImage('web_images/super_Admin (1).jpg'),
              // ),
              Center(
                  child: GooglePoppinsWidgets(
                text: text,
                fontsize: 11,
                fontWeight: FontWeight.bold,
              )),
            ],
          )),
    );
  }
}
