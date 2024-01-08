import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/delivery_management/delivery_orders/view_deliveryProducts.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class RequestProductOrders extends StatelessWidget {
  final AddProductController addProductController =
      Get.put(AddProductController());
  RequestProductOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('EmployeeProfile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('storeRequest')
            .where('pending', isEqualTo: true)
            .snapshots(),
        builder: (context, snaps) {
          if (snaps.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final data = snaps.data!.docs[index];

                return Container(
                    height: 80,
                    color: const Color.fromARGB(255, 35, 173, 144)
                        .withOpacity(0.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GooglePoppinsWidgets(
                          text: ' ${index + 1}',
                          fontsize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "Item  :", fontsize: 12),
                                    SizedBox(
                                      width: 100,
                                      child: TextScroll(
                                        " ${data['productName']}",
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "QTY  ", fontsize: 12),
                                    GooglePoppinsWidgets(
                                      text: data['quantity'].toString(),
                                      fontsize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            // viewDeliveyProducts(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 235, 26, 11)
                                  .withOpacity(0.5),
                              borderRadius: const BorderRadius.horizontal(),
                            ),
                            width: 80,
                            child: Center(
                              child: GooglePoppinsWidgets(
                                textAlign: TextAlign.center,
                                color: cWhite,
                                fontWeight: FontWeight.bold,
                                text: "Pending",
                                fontsize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              },
              itemCount: snaps.data!.docs.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 3,
              ),
            );
          } else {
            return Center(
              child: GooglePoppinsWidgets(text: "No records", fontsize: 16),
            );
          }
        });
  }
}
