// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:canteen_productadd_application/controller/delivery_controller/delivery_controller.dart';
import 'package:canteen_productadd_application/model/delivery/deliveryProduct_model/deliveryproduct_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/screens/io_device.dart';

import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
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
            customShowDilogBox(
                context: context,
                title: 'Picked Item',
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
                actiontext: 'Pick up item',
                actiononTapfuction: () async {
                  if (productcount ==
                      int.parse(itemcountController.text.trim())) {
                    deliveryController.pickedItem(
                        deliverydocid, docid, deliveryProductListModel);
                  } else {
                    showToast(msg: 'Count Mismatch');
                  }
                },
                doyouwantActionButton: true);
          } else {
            Get.back();
            showToast(msg: "Product Mismatch");
          }
        });
  }
}
