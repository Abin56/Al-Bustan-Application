import 'dart:developer';

import 'package:canteen_productadd_application/model/product_category_model/product_category_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/add_product/add_product.dart';
import 'package:canteen_productadd_application/view/add_product/requesr_products/request_addProduct.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  TextEditingController productnameController = TextEditingController();
  TextEditingController productpriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController expirydateController = TextEditingController();
  RxString recCatDocID = ''.obs;
  RxString recCatName = ''.obs;
  RxBool recCatisLoading = false.obs;
  List<ProductCategoryModel> productCatList = [];

  Future<void> addProduct(
    String barcodeNumber,
    BuildContext context,
  ) async {
    final productdetails = ProductAddingModel(
      categoryID: Get.find<AddProductController>().recCatDocID.value,
      categoryName: Get.find<AddProductController>().recCatName.value,
      authuid: FirebaseAuth.instance.currentUser!.uid,
      docId: barcodeNumber,
      barcodeNumber: barcodeNumber,
      productname: productnameController.text,
      quantityinStock: int.parse(quantityController.text.trim()),
      price: int.parse(productpriceController.text.trim()),
      expiryDate: DateTime.now()
          .add(Duration(days: int.parse(expirydateController.text)))
          .toString(),
      addDate: DateTime.now().toString(),
    );
    await FirebaseFirestore.instance
        .collection('AllProduct')
        .doc(barcodeNumber)
        .set(productdetails.toMap())
        .then((value) => showToast(msg: 'Product Added'));
    productnameController.clear();
    productpriceController.clear();
    quantityController.clear();
    expirydateController.clear();
    Navigator.pop(context);
  }

  Future<List<ProductCategoryModel>> fetchProductCategory() async {
    final firebase =
        await FirebaseFirestore.instance.collection('ProductCategory').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs
          .map((e) => ProductCategoryModel.fromMap(e.data()))
          .toList();
      productCatList.add(list[i]);
      log("message$productCatList");
    }

    return productCatList;
  }

  Future<void> checkProductAreSame(String docid, BuildContext context,String storeID) async {
    try {
      final firebasecollection = await FirebaseFirestore.instance
          .collection('AllProduct')
          .doc(docid)
          .get();
      if (firebasecollection.data() == null) {
        showToast(msg: "No Product found");
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return RequestAddProduct(barcodeValue: docid,docid: storeID,);
          },
        ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addRequesTProduct(
    String barcodeNumber,
    String docid,
    BuildContext context,
  ) async {
    final firebasecollection = FirebaseFirestore.instance
        .collection('EmployeeProfile')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('storeRequest')
        .doc(docid);

    final productdetails = ProductAddingModel(
      categoryID: Get.find<AddProductController>().recCatDocID.value,
      categoryName: Get.find<AddProductController>().recCatName.value,
      authuid: FirebaseAuth.instance.currentUser!.uid,
      docId: barcodeNumber,
      barcodeNumber: barcodeNumber,
      productname: productnameController.text,
      quantityinStock: int.parse(quantityController.text.trim()),
      price: int.parse(productpriceController.text.trim()),
      expiryDate: DateTime.now()
          .add(Duration(days: int.parse(expirydateController.text)))
          .toString(),
      addDate: DateTime.now().toString(),
    );
    await FirebaseFirestore.instance
        .collection('AllProduct')
        .doc(barcodeNumber)
        .set(productdetails.toMap())
        .then((value) async {
      await firebasecollection.update({'pending': false});
    }).then((value) => showToast(msg: 'Product Added'));
    productnameController.clear();
    productpriceController.clear();
    quantityController.clear();
    expirydateController.clear();

    Navigator.pop(context);
  }
}
