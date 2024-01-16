// ignore_for_file: use_build_context_synchronously

import 'package:canteen_productadd_application/controller/barcode_controller/barcode_controller.dart';
import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';

import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductList extends StatelessWidget {
  final BarcodeController barcodeController = Get.put(BarcodeController());


  // final AddProductController productListController =Get.find<AddProductController>();

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 5),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             GooglePoppinsWidgets(
      //               text: 'ALBUSTAN',
      //               fontsize: 15,
      //               textAlign: TextAlign.center,
      //               fontWeight: FontWeight.w600,
      //             ),
      //             GooglePoppinsWidgets(
      //               text: 'BAKERY N SWEETS',
      //               fontsize: 15,
      //               textAlign: TextAlign.center,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('AllProduct')
            .where('authuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            // .orderBy('addDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final data = AllProductDetailModel.fromMap(
                        snapshot.data!.docs[index].data());
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GooglePoppinsWidgets(
                                text: 'Product Name', fontsize: 12),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: GooglePoppinsWidgets(
                                  text: data.productname, fontsize: 18),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GooglePoppinsWidgets(
                                  text: 'Barcode :  ', fontsize: 12),
                              GooglePoppinsWidgets(
                                text: data.barcodeNumber.toString(),
                                fontsize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GooglePoppinsWidgets(
                              text: 'Stock : ${data.quantityinStock}',
                              fontsize: 16),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext cotext, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: snapshot.data!.docs.length);
            } else {
              return const Center(
                child: Text('No data found'),
              );
            }
          }
        },
      ),
    );
  }
}
