import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';

class EmployeeProfileHomePage extends StatelessWidget {
  const EmployeeProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                        GooglePoppinsWidgets(text: "Name", fontsize: 17,fontWeight: FontWeight.bold,),
                        GooglePoppinsWidgets(text: "Employee ID", fontsize: 13)
                      ],
                    ),
                  )
                ],
              ),
            ),
             Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Container(
                      //  width: 200,
                        height: 40,
                        color: const Color.fromARGB(255, 2,179,89),
                        child: Center(child: GoogleMonstserratWidgets(text: "Add Product", fontsize: 12,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                  ),
                   Expanded(
                    flex: 1,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 7,),
                       child: Container(
                      //  width: 200,
                        height: 40,
                        color: const Color.fromARGB(255,25,165,152),
                        child: Center(child: GoogleMonstserratWidgets(text: "Add New Product", fontsize: 12,fontWeight: FontWeight.bold,)),
                      ),
                     ),
                   )
                ],
                         ),
             ),
          
             Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Container(
                       // width: 200,
                        height: 40,
                        color: const Color.fromARGB(255, 2,179,89).withOpacity(0.7),
                        child: Center(child: GoogleMonstserratWidgets(text: "Request", fontsize: 12,fontWeight: FontWeight.bold,)),
                      ),
                    ),
                  ),
                   Expanded(
                    flex: 1,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 7),
                       child: Container(
                      //  width: 200,
                        height: 40,
                        color: const Color.fromARGB(255, 105,205,208),
                        child: Center(child: GoogleMonstserratWidgets(text: "Approvals", fontsize: 12,fontWeight: FontWeight.bold,)),
                      ),
                     ),
                   )
                ],
                         ),
             ),
            SizedBox(
              height: 50,
              child: AppBar(
                bottom:  TabBar(
                  tabs: [
                    Tab(
                      //icon: const Icon(Icons.production_quantity_limits_rounded),
                      child: GooglePoppinsWidgets(text: "Product Orders", fontsize: 12,fontWeight: FontWeight.w500,),
                    ),
                     Tab(
                      child: GooglePoppinsWidgets(text: "Delivery Orders", fontsize: 12,fontWeight: FontWeight.w500,),
                      // icon: Icon(
                      //   Icons.location_history,
                      // ),
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        //  width: 200,
                         // height: 100,
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
                        );
                    },
                   itemCount: 10,
                   separatorBuilder: (context, index) => const SizedBox(height: 3,),
                  ),

                  // second tab bar viiew widget
                 ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                         // width: 200,
                         // height: 100,
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
                                         );
                  },
                   itemCount: 10,
                   separatorBuilder: (context, index) => const SizedBox(height: 5,),
                 ),
                ],
              ),
            ),
              //  Padding(
              //    padding: const EdgeInsets.all(8.0),
              //    child: Row(
              //      children: [
              //     Expanded(
              //       flex: 1,
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 7),
              //         child: 
              //       ),
              //     ),
              //      Expanded(
              //       flex: 1,
              //        child: Padding(
              //          padding: const EdgeInsets.only(left: 7),
              //          child: 
              //        ),
              //      )
              //                ],
              //              ),
              //  ),
          ],
        ),
      ),
    );
  }
}



