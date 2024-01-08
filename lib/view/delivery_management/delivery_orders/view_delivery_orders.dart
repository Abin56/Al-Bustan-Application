import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/model/delivery/view_delivery_orders.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/delivery_management/delivery_orders/view_deliveryProducts.dart';
import 'package:canteen_productadd_application/view/delivery_management/sign_pad/sign_pad.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class DeliveryOrdersWidget extends StatelessWidget {
  final AddProductController addProductController =
      Get.put(AddProductController());
  DeliveryOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('EmployeeProfile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('DeliveryRequest')
            .orderBy('time', descending: false)
            .snapshots(),
        builder: (context, snaps) {
          if (snaps.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final data =
                    DeliveryOrdersModel.fromMap(snaps.data!.docs[index].data());

                return GestureDetector(
                  onTap: () => viewDeliveyProducts(context, data.orderId),
                  child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GooglePoppinsWidgets(
                                          text: "Item  :", fontsize: 12),
                                      SizedBox(
                                        width: 100,
                                        child: TextScroll(
                                          " ${data.orderId}",
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
                                        text: data.orderCount.toString(),
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
                            onTap: () =>
                                viewDeliveyProducts(context, data.orderId),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('EmployeeProfile')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('DeliveryRequest')
                                    .doc(data.orderId)
                                    .collection('productsDetails')
                                    .snapshots(),
                                builder: (context, statussnaps) {
                                  if (statussnaps.hasData) {
                                    if (statussnaps.data!.docs.isEmpty) {
                                      final result =
                                          snaps.data!.docs[index]['status'];
                                      return result == 'Delivered'
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: themeColorBlue
                                                    .withOpacity(0.5),
                                                borderRadius: const BorderRadius
                                                    .horizontal(),
                                              ),
                                              width: 80,
                                              child: Center(
                                                child: GooglePoppinsWidgets(
                                                  textAlign: TextAlign.center,
                                                  color: cWhite,
                                                  fontWeight: FontWeight.bold,
                                                  text: "Delivered",
                                                  fontsize: 12,
                                                ),
                                              ),
                                            )
                                          : Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ButtonContainerWidget(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      text: "SIGN",
                                                      width: 100,
                                                      height: 40,
                                                      fontSize: 11,
                                                      onTap: () async {
                                                        Get.to(
                                                            () => SignPadScreen(
                                                                  deliverydocid:
                                                                      data.orderId,
                                                                  deliveryOrdersModel:
                                                                      data,
                                                                ));
                                                      }),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                            255, 19, 136, 4)
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        const BorderRadius
                                                            .horizontal(),
                                                  ),
                                                  width: 80,
                                                  child: Center(
                                                    child: GooglePoppinsWidgets(
                                                      textAlign:
                                                          TextAlign.center,
                                                      color: cWhite,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      text: "Pickuped",
                                                      fontsize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 235, 26, 11)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              const BorderRadius.horizontal(),
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
                                      );
                                    }
                                  } else {
                                    return circularPIndicator;
                                  }
                                }),
                          ),
                        ],
                      )),
                );
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
