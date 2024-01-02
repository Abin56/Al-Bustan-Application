import 'package:canteen_productadd_application/controller/user_getDetails_controller.dart/user_auth_controller.dart';
import 'package:canteen_productadd_application/view/add_product/list%20products/add_product_manual.dart';
import 'package:canteen_productadd_application/view/add_product/list%20products/product_list.dart';
import 'package:canteen_productadd_application/view/add_product/requesr_products/request_products.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class EmployeeProfileHomePage extends StatelessWidget {
  const EmployeeProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("EmployeeProfile")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snap) {
            if (snap.hasData) {
              return Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(snap.data!.data()!['imageURl']),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Name :", fontsize: 16),
                                    SizedBox(
                                      child: TextScroll(
                                        ' ${snap.data!.data()!['name']}',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Email :", fontsize: 12),
                                    SizedBox(
                                      child: TextScroll(
                                        ' ${snap.data!.data()!['email']}',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Phone No :", fontsize: 12),
                                    SizedBox(
                                      child: TextScroll(
                                        ' ${snap.data!.data()!['phoneNo']}',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Status :", fontsize: 12),
                                    SizedBox(
                                      child: TextScroll(
                                        snap.data!.data()!['activate'] == true
                                            ? '  Active'
                                            : 'Not Active',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => const ProductList());
                                },
                                child: Container(
                                  //  width: 200,
                                  height: 40,
                                  color: const Color.fromARGB(255, 2, 179, 89),
                                  child: Center(
                                      child: GoogleMonstserratWidgets(
                                    text: "Scan Product",
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 7,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => AddProductManual());
                                },
                                child: Container(
                                  //  width: 200,
                                  height: 40,
                                  color:
                                      const Color.fromARGB(255, 25, 165, 152),
                                  child: Center(
                                      child: GoogleMonstserratWidgets(
                                    text: "Add New Product",
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
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
                                color: const Color.fromARGB(255, 2, 179, 89)
                                    .withOpacity(0.7),
                                child: Center(
                                    child: GoogleMonstserratWidgets(
                                  text: "Request",
                                  fontsize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
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
                                color: const Color.fromARGB(255, 105, 205, 208),
                                child: Center(
                                    child: GoogleMonstserratWidgets(
                                  text: "Approvals",
                                  fontsize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: AppBar(
                        bottom: TabBar(
                          // indicatorColor: Colors.grey,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              //icon: const Icon(Icons.production_quantity_limits_rounded),
                              child: GooglePoppinsWidgets(
                                text: "Product Orders",
                                fontsize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Tab(
                              child: GooglePoppinsWidgets(
                                text: "Delivery Orders",
                                fontsize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              // icon: Icon(
                              //   Icons.location_history,
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: TabBarView(
                        children: [
                          // first tab bar view widget

                          RequestProductOrders(),
                          // second tab bar viiew widget
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return Container(
                                // width: 200,
                                // height: 100,
                                color: const Color.fromARGB(255, 1, 171, 160)
                                    .withOpacity(0.7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: cGreen,
                                      width: 50,
                                      height: 30,
                                      child: Center(
                                          child: GooglePoppinsWidgets(
                                        text: "${index + 1}",
                                        fontsize: 11,
                                        color: cWhite,
                                      )),
                                    ),
                                    Center(
                                        child: GoogleMonstserratWidgets(
                                      text: "Delivery Orders",
                                      fontsize: 14,
                                      fontWeight: FontWeight.bold,
                                    ))
                                  ],
                                ),
                              );
                            },
                            itemCount: 10,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }
}
