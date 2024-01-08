import 'package:canteen_productadd_application/model/delivery/deliveryProduct_model/deliveryproduct_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/delivery_management/pick_upItems/pick_up_items.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

viewDeliveyProducts(BuildContext context, String docid) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builderContext) {
      return Container(
        height: 400,
        color: Colors.white,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('EmployeeProfile')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('DeliveryRequest')
                .doc(docid)
                .collection('productsDetails')
                .snapshots(),
            builder: (context, snaps) {
              if (snaps.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final data = DeliveryProductListModel.fromMap(
                          snaps.data!.docs[index].data());
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GooglePoppinsWidgets(
                                              text: "Item  :", fontsize: 12),
                                          SizedBox(
                                            width: 150,
                                            child: TextScroll(
                                              data.productname,
                                              style: const TextStyle(
                                                color: cBlack,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
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
                                            text:
                                                data.quantityinStock.toString(),
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
                                  Get.to(PickItemsScreen(
                                    deliveryProductListModel:data ,
                                    deliverydocid: docid,
                                    barcode: data.barcodeNumber,
                                    docid: data.docId,
                                    productcount: data.quantityinStock,
                                    productname: data.productname,
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 11, 159, 14)
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
                                      text: "Pick up",
                                      fontsize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snaps.data!.docs.length);
              } else {
                return const Center(
                  child: circularPIndicator,
                );
              }
            }),
      );
    },
  );
}
