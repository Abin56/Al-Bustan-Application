import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return
           Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 110,
            color: const Color.fromARGB(255, 24,192,204).withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 90,
                      color: Colors.blue.withOpacity(0.8),
                      child: Center(child: GooglePoppinsWidgets(text: "Request", fontsize: 14,color: cWhite,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GooglePoppinsWidgets(text: "Product Name", fontsize: 15,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GooglePoppinsWidgets(text: "Quantity: 100", fontsize: 14,),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: GooglePoppinsWidgets(text: "Duration: 3hrs", fontsize: 12),
                     ),
                    Container(
                      height: 30,
                      width: 70,
                      color: cred.withOpacity(0.8),
                      child: Center(child: GooglePoppinsWidgets(text: "Cancel", fontsize: 12,color: cWhite,)),
                    ),
                  ],
                ),
                 Container(
                  width: 70,
                  height: double.infinity,
                  color: Colors.green.withOpacity(0.8),
                  child: Center(child: GooglePoppinsWidgets(text: "Add\nProduct", fontsize: 13,color: cWhite,fontWeight: FontWeight.bold,)),
                )
              ],
            ),
          ),
        );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        } ,
        itemCount:10,
      ),
    );
  }
}