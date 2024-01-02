import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/user_profile/edit/dialog_box.dart';
import 'package:flutter/material.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255,130,202,156).withOpacity(0.1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(minRadius: 80,),
            ),
           // GooglePoppinsWidgets(text: "Name", fontsize: 15),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GooglePoppinsWidgets(text: "Name", fontsize: 12),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: cWhite),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GooglePoppinsWidgets(text: "Name", fontsize: 14),
                        ),
                         GestureDetector(
                           onTap: () {
                            editProfileFunctionOfName(context);
                          },
                          child: const Icon(Icons.edit,size: 16,))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GooglePoppinsWidgets(text: "Mobile Number", fontsize: 12),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: cWhite),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GooglePoppinsWidgets(text: "Mobile Number", fontsize: 14),
                        ),
                         GestureDetector(
                          onTap: () {
                            editProfileFunctionOfNumber(context);
                          },
                          child: const Icon(Icons.edit,size: 16,))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GooglePoppinsWidgets(text: "Email Id", fontsize: 12),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: cWhite),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GooglePoppinsWidgets(text: "Email Id", fontsize: 14),
                        ),
                         GestureDetector(
                           onTap: () {
                            editProfileFunctionOfEmail(context);
                          },
                          child: const Icon(Icons.edit,size: 16,))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}