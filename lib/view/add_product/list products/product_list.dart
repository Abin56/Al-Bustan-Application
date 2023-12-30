// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/add_product/add_product.dart';
import 'package:canteen_productadd_application/view/add_product/list%20products/add_product_manual.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProductList extends StatelessWidget {
  // final AddProductController productListController =Get.find<AddProductController>();

  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
             actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
             Get.to(()=>AddProductManual());
              },
              child: Container(
                color: themeColorBlue.withOpacity(0.2),
                height: 40,
                width: 200,
                child: Center(
                  child: GooglePoppinsWidgets(
                    text: "ADD PRODUCT MANUAL",
                    fontsize: 13,
                    color: cBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //  height: 200,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/images/albustanblack.png"))),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GooglePoppinsWidgets(
                    text: 'ALBUSTAN',
                    fontsize: 15,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                  GooglePoppinsWidgets(
                    text: 'BAKERY N SWEETS',
                    fontsize: 15,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('AllProduct')
            .orderBy('addDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final data = ProductAddingModel.fromMap(
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
                                text: data.barcodeNumber,
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
      floatingActionButton: ButtonContainerWidget(
          text: 'Add Product',
          width: 100,
          height: 40,
          fontSize: 12,
          onTap: () async {
            await BarcodeScanner.scan().then((value) async {
              final firebase = await FirebaseFirestore.instance
                  .collection('AllProduct')
                  .doc(value.rawContent)
                  .get();
              final data = ProductAddingModel.fromMap(firebase.data()!);

              if (firebase.data() == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(
                      barcodeValue: value.rawContent,
                    ),
                  ),
                );
              } else {
                await customShowDilogBox(
                    context: context,
                    title: 'Product Details',
                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 295,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Center(
                                      child: Container(
                                        color: Colors.amber.withOpacity(0.4),
                                        height: 60,
                                        width: 290,
                                        child: Center(
                                          child: SfBarcodeGenerator(
                                            symbology: Code128(),
                                            value: value.rawContent,
                                            showValue: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  sh10,
                                  const Text(
                                    "Product Name",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  GooglePoppinsWidgets(
                                    text: data.productname,
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sh10,
                                  const Text(
                                    "Stock",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  GooglePoppinsWidgets(
                                    text: data.quantityinStock.toString(),
                                    fontsize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sh10,
                                  const Text(
                                    "ExpiryDate",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  GooglePoppinsWidgets(
                                    text: dateConveter(
                                        DateTime.parse(data.expiryDate)),
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                    actiononTapfuction: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProduct(
                            barcodeValue: value.rawContent,
                          ),
                        ),
                      );
                    },
                    actiontext: 'Add Product',
                    doyouwantActionButton: true);
              }
              log('message');

              // Get.to(()=>
              // AddProduct(barcodeValue: value.rawContent,));
            });
          }),
    );
  }
}
