// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:canteen_productadd_application/controller/delivery_controller/delivery_controller.dart';
import 'package:canteen_productadd_application/model/delivery/deliveryProduct_model/deliveryproduct_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/screens/io_device.dart';

import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';

class PickItemsScreen extends StatelessWidget {
  final DeliveryController deliveryController = Get.put(DeliveryController());
  final DeliveryProductListModel deliveryProductListModel;
  final String deliverydocid;
  final String productname;
  final int productcount;
  final String barcode;
  final String docid;
  PickItemsScreen({
    Key? key,
    required this.productname,
    required this.productcount,
    required this.barcode,
    required this.docid,
    required this.deliverydocid,
    required this.deliveryProductListModel,
  }) : super(key: key);
  final TextEditingController itemcountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BarcodeScanner(
        lineColor: '#ff6666',
        cancelButtonText: "Cancel",
        isShowFlashIcon: false,
        scanType: ScanType.barcode,
        appBarTitle: '',
        centerTitle: true,
        onScanned: (res) async {
          if (barcode == '-1') {
            return Get.back();
          }
          if (barcode == res) {
            showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GooglePoppinsWidgets(
                          text: 'Picked Item',
                          fontsize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: themeColorBlue,
                              ),
                              child: Center(
                                child: GooglePoppinsWidgets(
                                  text: 'BACK',
                                  color: cWhite,
                                  fontsize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          GoogleMonstserratWidgets(
                            text: productname,
                            fontsize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          Center(
                              child: GoogleMonstserratWidgets(
                            text: productcount.toString(),
                            fontsize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                          TextFormFiledContainerWidget(
                              keyboardType: TextInputType.number,
                              controller: itemcountController,
                              hintText: "Enter Count",
                              title: "Item Count",
                              width: 200)
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if (productcount ==
                              int.parse(itemcountController.text.trim())) {
                            deliveryController.pickedItem2(
                                deliverydocid, docid, deliveryProductListModel);
                          } else {
                            showToast(msg: 'Count Mismatch');
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 250,
                          decoration: const BoxDecoration(
                            color: themeColorBlue,
                          ),
                          child: Center(
                            child: GooglePoppinsWidgets(
                                text: 'Pickup item',
                                color: cWhite,
                                fontsize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ]);
              },
            );
          } else {
            Get.back();
            showToast(msg: "Product Mismatch");
          }
        });
  }
}
