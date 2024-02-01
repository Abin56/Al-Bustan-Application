// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:canteen_productadd_application/view/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/screens/io_device.dart';

import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/controller/barcode_controller/barcode_controller.dart';
import 'package:canteen_productadd_application/controller/search_product_controller/search_product_controller.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/pages/add_Product/add_product.dart';

class AllTempProductSearch extends SearchDelegate {
  String navvalue;
  AllTempProductSearch({
    required this.navvalue,
  });
  final AddProductController addProductController =
      Get.put(AddProductController());
  final BarcodeController barcodeController = Get.put(BarcodeController());
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ProductAddingModel> suggestionList;

    if (query.isEmpty) {
      suggestionList = Get.find<SearchProductController>().alltempProducts;
    } else {
      suggestionList =
          Get.find<SearchProductController>().alltempProducts.where((item) {
        log("++++");

        return item.productname.toLowerCase().contains(query.toLowerCase());
      }).toList();
      // suggestionList = Get.find<SearchProductController>().dropdown.value ==
      //         true
      //     ? Get.find<SearchProductController>().alltempProducts.where((item) {
      //         log("...........................");

      //         return item.productname
      //                 .toLowerCase()
      //                 .contains(query.toLowerCase()) &&
      //             item.companyNameID
      //                 .contains('55408980-6ed6-1e5e-9fe5-ab92f774d3d2');
      //       }).toList()
      //     : Get.find<SearchProductController>().alltempProducts.where((item) {
      //         log("++++");

      //         return item.productname
      //             .toLowerCase()
      //             .contains(query.toLowerCase());
      //       }).toList();
    }
    if (suggestionList.isEmpty) {
      return ListTile(
        title: GooglePoppinsWidgets(
          text: "No Product found",
          fontsize: 18,
          fontWeight: FontWeight.w400,
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final ProductAddingModel data = suggestionList[index];
            return GestureDetector(
              onTap: () async {
                navvalue == 'add'
                    ? Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          Future.delayed(const Duration(seconds: 1));
                          Get.back();

                          return BarcodeScanner(
                              lineColor: '#ff6666',
                              cancelButtonText: "Cancel",
                              isShowFlashIcon: false,
                              scanType: ScanType.barcode,
                              appBarTitle: '',
                              centerTitle: true,
                              onScanned: (res) async {
                                barcodeController.barcodevalue.value = res;
                                await barcodeController
                                    .barcodescanResult(res)
                                    .then((value) {
                                  if (Get.find<BarcodeController>()
                                              .barcodevalue
                                              .value ==
                                          '' ||
                                      Get.find<BarcodeController>()
                                              .barcodevalue
                                              .value ==
                                          '-1') {
                                    return Get.back();
                                  } else {
                                    Get.to(() => AddProductWareHouseAdmin(
                                          resultData: data,
                                          barcoodevalue:
                                              Get.find<BarcodeController>()
                                                  .barcodevalue
                                                  .value,
                                        ));
                                  }
                                });
                              });
                        },
                      ))
                    : Get.to(() => AddProductWareHouseAdmin(
                          resultData: data,
                          barcoodevalue: idGenerator(),
                        ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: const BeveledRectangleBorder(),
                  child: ListTile(
                    leading: const Icon(Icons.do_disturb_alt_sharp),
                    title: GooglePoppinsWidgets(
                      text: data.productname,
                      fontsize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle: GooglePoppinsWidgets(
                      text: data.companyName,
                      fontsize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: suggestionList.length,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }
}
   //  SizedBox(
    //             height: 80,
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 SizedBox(
    //                   width: 200,
    //                   child: Center(
    //                       child: DropdownSearch<SuppliersModel>(
    //                     autoValidateMode: AutovalidateMode.always,
    //                     asyncItems: (value) {
    //                       Get.find<SearchProductController>()
    //                           .allCompayList
    //                           .clear();

    //                       return Get.find<SearchProductController>()
    //                           .fetchallCompany();
    //                     },
    //                     itemAsString: (value) => value.suppliersName,
    //                     onChanged: (value) async {
    //                       if (value != null) {
    //                         Get.find<SearchProductController>()
    //                             .companyName
    //                             .value = value.docId;

    //                         log("companyid:${Get.find<SearchProductController>().companyName}");
    //                         Get.find<SearchProductController>().dropdown.value =
    //                             true;
    //                         // Get.find<SearchProductController>().packageTypeID.value = value.docid;

    //                         // Get.find<SearchProductController>().packageTypeEdit(
    //                         //     value.typevalue, data['docId']);
    //                       }
    //                     },
    //                     dropdownDecoratorProps: DropDownDecoratorProps(
    //                         baseStyle: GoogleFonts.poppins(
    //                             fontSize: 13,
    //                             color: Colors.black.withOpacity(0.7))),
    //                   )),
    //                 ),
    //               ],
    //             ),
    //           ),