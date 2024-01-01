import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class EmployeeProfileHomePage extends StatelessWidget {
  const EmployeeProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(minRadius: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GooglePoppinsWidgets(text: "Name", fontsize: 15,fontWeight: FontWeight.bold,),
                      GooglePoppinsWidgets(text: "Employee ID", fontsize: 13)
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Container(
                  width: 200,
                  height: 100,
                  color: const Color.fromARGB(255, 35,173,144),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: cGreen,
                        width: 50,
                        height: 30,
                        child: Center(child: GooglePoppinsWidgets(text: "New", fontsize: 11,color: cWhite,)),
                      ),
                      Center(child: GoogleMonstserratWidgets(text: "Product Orders", fontsize: 14,fontWeight: FontWeight.bold,))
                    ],
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(left: 7),
                 child: Container(
                  width: 200,
                  height: 100,
                  color: const Color.fromARGB(255, 1,171,160).withOpacity(0.7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: cGreen,
                        width: 50,
                        height: 30,
                        child: Center(child: GooglePoppinsWidgets(text: "New", fontsize: 11,color: cWhite,)),
                      ),
                      Center(child: GoogleMonstserratWidgets(text: "Delivery Orders", fontsize: 14,fontWeight: FontWeight.bold,))
                    ],
                  ),
                ),
               )
            ],
          ),
           Padding(
             padding: const EdgeInsets.only(top: 10),
             child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Container(
                    width: 200,
                    height: 100,
                    color: const Color.fromARGB(255, 2,179,89).withOpacity(0.7),
                    child: Center(child: GoogleMonstserratWidgets(text: "Request", fontsize: 14,fontWeight: FontWeight.bold,)),
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.only(left: 7),
                   child: Container(
                    width: 200,
                    height: 100,
                    color: const Color.fromARGB(255, 105,205,208),
                    child: Center(child: GoogleMonstserratWidgets(text: "Approvals", fontsize: 14,fontWeight: FontWeight.bold,)),
                  ),
                 )
              ],
                       ),
           ),
            Padding(
             padding: const EdgeInsets.only(top: 10),
             child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Container(
                    width: 200,
                    height: 100,
                    color: const Color.fromARGB(255, 2,179,89),
                    child: Center(child: GoogleMonstserratWidgets(text: "Add Product", fontsize: 14,fontWeight: FontWeight.bold,)),
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.only(left: 7),
                   child: Container(
                    width: 200,
                    height: 100,
                    color: const Color.fromARGB(255,25,165,152),
                    child: Center(child: GoogleMonstserratWidgets(text: "Add New Product", fontsize: 14,fontWeight: FontWeight.bold,)),
                  ),
                 )
              ],
                       ),
           )
        ],
      ),
    );
  }
}