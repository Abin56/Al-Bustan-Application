import 'dart:developer';

import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/controller/barcode_controller/barcode_controller.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:canteen_productadd_application/view/widgets/textform%20feild%20Widget/textformfeildWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/screens/io_device.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class AddStockScanPage extends StatelessWidget {
  final AddProductController addProductController =
      Get.put(AddProductController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final BarcodeController barcodeController = Get.put(BarcodeController());
  AddStockScanPage({super.key});

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
        Navigator.pop(context, res);
        barcodeController.barcodevalue.value = res;
        try {
          barcodeController.barcodevalue.value = res;
          await barcodeController.barcodescanResult(res).then((value) async {
            if (addProductController.allproductList
                .any((element) => element.barcodeNumber == res)) {
              final result = Get.find<AddProductController>()
                  .allproductList
                  .where((element) => element.barcodeNumber.contains(res))
                  .toList();
              final dataList = result[0];

              await customShowDilogBox(
                  context: context,
                  title: 'Product Details',
                  children: [
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: 350,
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
                                            value: res,
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
                                    text: dataList.productname,
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sh10,
                                  const Text(
                                    "Stock",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Row(
                                    children: [
                                      GooglePoppinsWidgets(
                                        text:
                                            dataList.quantityinStock.toString(),
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          addProductController
                                              .editexpirydate.value = true;
                                        },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.green,
                                      ),
                                      Obx(() => addProductController
                                                  .editexpirydate.value ==
                                              true
                                          ? Row(
                                              children: [
                                                TextFormFiledContainerWidget(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller:
                                                        addProductController
                                                            .editqtyController,
                                                    validator: checkFieldEmpty,
                                                    hintText: 'Stock',
                                                    title: "Add Stock",
                                                    width: 100),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 30),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            addProductController
                                                                .editexpirydate
                                                                .value = false;
                                                          },
                                                          child: Container(
                                                            color: Colors.red,
                                                            height: 30,
                                                            width: 30,
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.close,
                                                                color: cWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              addProductController
                                                                  .isloading
                                                                  .value = true;
                                                              await addProductController.updateStock(
                                                                  dataList
                                                                      .docId,
                                                                  dataList
                                                                      .quantityinStock,
                                                                  int.parse(addProductController
                                                                      .editqtyController
                                                                      .text
                                                                      .trim()));
                                                            }
                                                          },
                                                          child: Container(
                                                            color: Colors.green,
                                                            height: 30,
                                                            width: 30,
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.check,
                                                                color: cWhite,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            )
                                          : addProductController
                                                      .isloading.value ==
                                                  true
                                              ? circularPIndicator
                                              : const Text('')),
                                    ],
                                  ),
                                  sh10,
                                  const Text(
                                    "Category",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  GooglePoppinsWidgets(
                                    text: dataList.categoryName,
                                    fontsize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sh10,
                                  const Text(
                                    "Package Type",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  GooglePoppinsWidgets(
                                    text: dataList.packageType,
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
                                        DateTime.parse(dataList.expiryDate)),
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],

                  // actiontext: 'Add Product',
                  doyouwantActionButton: false);
            } else {
              showToast(msg: 'No Product Found');
            }
          });
        } catch (e) {
          log(e.toString());
          showToast(msg: 'Error fetching data');
        }
      },
    );
  }
}
