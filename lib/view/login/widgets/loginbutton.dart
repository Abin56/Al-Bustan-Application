import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class loginButtonWidget extends StatelessWidget {
  String text;
  double height;
  double width;

  loginButtonWidget({
    required this.height,
    required this.width,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(05)),
        color: themeColorBlue,
      ),
      child: Center(
        child: GooglePoppinsWidgets(text: text, fontsize: 18,color: cWhite,fontWeight: FontWeight.bold,)
        
      ),
    );
  }
}
