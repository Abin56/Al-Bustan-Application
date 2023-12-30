import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  TextEditingController productnameController = TextEditingController();
  TextEditingController productpriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController expirydateController = TextEditingController();

  Future<void> addProduct(String barcodeNumber,BuildContext context) async {
    final productdetails = ProductAddingModel(
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


}
