import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class DeliveryAdminListContainers extends StatelessWidget {
  final int flex;
  final String text;
  const DeliveryAdminListContainers({
    required this.text,
    required this.flex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
     flex: flex,
     child: Container(
     height: 45,
      decoration:   BoxDecoration(
        border:  const Border(
          right: BorderSide(
            color: cWhite,width: 5),
            bottom: BorderSide(
              color: cWhite)),
              color: Colors.pink.withOpacity(0.1) ),
     child: Center(child: GooglePoppinsWidgets(text: text, fontsize: 13,fontWeight: FontWeight.w500,)),
                        ),
                      );
  }
}

class HeaderOfDeliveryAdmin extends StatelessWidget {
  final String text;
   final int flex;
  const HeaderOfDeliveryAdmin({
    required this.text,
    required this.flex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
     flex: flex,
     child: Container(
       height: 45,
       decoration:  BoxDecoration(
        border: const Border(
          right: BorderSide(
            color: cWhite,width: 5)), 
            color: cBlue.withOpacity(0.5)
            ),
      
       child: Center(child: GoogleLoraWidgets(text: text, fontsize: 14,fontWeight: FontWeight.w700,)),
     ),
                      );
  }
}