import 'package:canteen_productadd_application/controller/search_product_controller/search_product_controller.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/navbar/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WareHouseController extends GetxController {
  RxBool productuploading = false.obs;
  TextEditingController inpriceController = TextEditingController();
  TextEditingController outpriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController expirydateController = TextEditingController();

  Future<void> addProduct(
    String docid,
    int barcodeNumber,
    String itemcode,
    ProductAddingModel data,
    BuildContext context,
  ) async {
    try {
      final productdetails = ProductAddingModel(
        productname: data.productname,
        companyNameID: data.categoryName,
        packageTypeID: data.packageTypeID,
        unitcategoryID: data.unitcategoryID,
        unitcategoryName: data.unitcategoryName,
        addedDate: DateTime.now().toString(),
        isavailable: true,
        itemcode: itemcode,
        outofstock: false,
        subcategoryID: data.subcategoryID,
        subcategoryName: data.subcategoryName,
        companyName: data.companyName,
        inPrice: int.parse(inpriceController.text),
        returnType: '',
        packageType: data.packageType,
        categoryID: data.categoryID,
        categoryName: data.categoryName,
        authuid: FirebaseAuth.instance.currentUser!.uid,
        docId: docid,
        barcodeNumber: barcodeNumber.toString(),
        quantityinStock: int.parse(quantityController.text.trim()),
        outPrice: int.parse(outpriceController.text.trim()),
        expiryDate: DateTime.now()
            .add(Duration(days: int.parse(expirydateController.text)))
            .toString(),
      );
      await dataserver
          .collection('AllProductStockCollection')
          .doc(docid)
          .set(productdetails.toMap())
          .then((value) async {
        await dataserver
            .collection('TemporaryStockList')
            .doc(data.docId)
            .delete();
      }).then((value) async {
      Get.find<SearchProductController>().alltempProducts.clear();

      productuploading.value = false;
        Get.offAll(() =>  WareHouseAdminNavBar());

        outpriceController.clear();
        quantityController.clear();
        expirydateController.clear();
      });
      //     .then((value) => showToast(msg: 'Product Added'));


    } catch (e) {
      productuploading.value = false;
    }
  }
}
