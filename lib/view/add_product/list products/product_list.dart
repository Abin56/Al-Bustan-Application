import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/add_product/add_product.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  // final AddProductController productListController =Get.find<AddProductController>();

  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('AllProduct').snapshots(),
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
                            children: [
                              Expanded(
                                  child: GooglePoppinsWidgets(
                                      text: 'Barcode Number :', fontsize: 12)),
                              GooglePoppinsWidgets(
                                  text: data.barcodeNumber, fontsize: 16),
                            ],
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GooglePoppinsWidgets(
                              text: 'Available:${data.quantityinStock}',
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
      )),
      floatingActionButton: ButtonContainerWidget(
          text: 'Add Product',
          width: 100,
          height: 40,
          fontSize: 12,
          onTap: () async {
            await BarcodeScanner.scan().then((value)async {
        final firebase =    await  FirebaseFirestore.instance.collection('AllProduct').doc(value.rawContent).get();
              if (firebase.data()==null) {
                     Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProduct(
                    barcodeValue: value.rawContent,
                  ),
                ),
              );
              }else{
                customShowDilogBox(context: context, title: 'Product Details', children: [
                // Card(child: ListTile(title: GooglePoppinsWidgets(text: 'Product Name', fontsize: 12,),subtitle: ,),)
                ], doyouwantActionButton: true);
              }
              log('message');

          
              // Get.to(()=>
              // AddProduct(barcodeValue: value.rawContent,));
            });
          }),
    );
  }
}
