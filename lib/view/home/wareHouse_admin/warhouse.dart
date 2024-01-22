import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/controller/barcode_controller/barcode_controller.dart';
import 'package:canteen_productadd_application/controller/search_product_controller/search_product_controller.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/pages/search_product/search_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class WareHouseHomePage extends StatelessWidget {
  final SearchProductController searchProductController =
      Get.put(SearchProductController());
  final AddProductController addProductController =
      Get.put(AddProductController());
  final BarcodeController barcodeController = Get.put(BarcodeController());
  WareHouseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 80,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        GooglePoppinsWidgets(text: "  Name :", fontsize: 16),
                        const SizedBox(
                          child: TextScroll(
                            ' sadfd',
                            style: TextStyle(
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
                        GooglePoppinsWidgets(text: "  Email :", fontsize: 12),
                        const SizedBox(
                          child: TextScroll(
                            ' aweewrewr',
                            style: TextStyle(
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
                        const SizedBox(
                          child: TextScroll(
                            'sdsdewed',
                            style: TextStyle(
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
                    onTap: () async {
                      showSearch(
                          context: context,
                          delegate: AllTempProductSearch(navvalue: 'manual'));
                    },
                    child: Container(
                      //  width: 200,
                      height: 40,
                      color: const Color.fromARGB(255, 2, 179, 89),
                      child: Center(
                          child: GoogleMonstserratWidgets(
                        text: "Add Product Manually",
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
                    onTap: () async {
                      showSearch(
                          context: context,
                          delegate: AllTempProductSearch(navvalue: 'add'));
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     Future.delayed(const Duration(seconds: 1));
                      //     Get.back();

                      //     return BarcodeScanner(
                      //         lineColor: '#ff6666',
                      //         cancelButtonText: "Cancel",
                      //         isShowFlashIcon: false,
                      //         scanType: ScanType.barcode,
                      //         appBarTitle: '',
                      //         centerTitle: true,
                      //         onScanned: (res) async {
                      //           barcodeController.barcodevalue.value = res;
                      //           await barcodeController
                      //               .barcodescanResult(res)
                      //               .then((value) {
                      //             if (Get.find<BarcodeController>()
                      //                         .barcodevalue
                      //                         .value ==
                      //                     '' ||
                      //                 Get.find<BarcodeController>()
                      //                         .barcodevalue
                      //                         .value ==
                      //                     '-1') {
                      //               return Get.back();
                      //             } else {
                      //               Get.to(() => AddProductManual(
                      //                     barcoodevalue:
                      //                         Get.find<BarcodeController>()
                      //                             .barcodevalue
                      //                             .value,
                      //                   ));
                      //             }
                      //           });
                      //         });
                      //   },
                      // ));
                    },
                    child: Container(
                      //  width: 200,
                      height: 40,
                      color: const Color.fromARGB(255, 25, 165, 152),
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
      ],
    ));
  }
}
