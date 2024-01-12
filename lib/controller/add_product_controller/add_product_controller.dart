import 'dart:developer';

import 'package:canteen_productadd_application/model/All_product_model/All_productModel.dart';
import 'package:canteen_productadd_application/model/packagetype_model.dart';
import 'package:canteen_productadd_application/model/product_category_model/product_category_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/model/sub_category_model.dart';
import 'package:canteen_productadd_application/model/unit_cate_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/pages/add_product/requesr_products/request_addProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  RxString listfetchedDocid = ''.obs;
  RxBool editqty = false.obs;
  RxBool isloading = false.obs;
  TextEditingController editqtyController = TextEditingController();
  RxBool editexpirydate = false.obs;
  TextEditingController productnameController = TextEditingController();
  TextEditingController inpriceController = TextEditingController();
  TextEditingController outpriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController expirydateController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController brandnameController = TextEditingController();

  RxString recCatDocID = ''.obs;
  RxString recCatName = ''.obs;
  RxBool recCatisLoading = false.obs;
  List<ProductCategoryModel> productCatList = [];
  List<PackageTypeModel> packageTypeModel = [];
  RxString packageTypeName = ''.obs;
  RxString packageTypeID = ''.obs;
  List<SubCategoryModel> subCategoryModel = [];
  RxString subCategoryTypeName = ''.obs;
  RxString subCategoryTypeID = ''.obs;
  List<UnitCatModel> unitCategoryModel = [];
  RxString unitCategoryTypeName = ''.obs;
  RxString unitCategoryTypeID = ''.obs;
  List<AllProductDetailModel> allproductList = [];
  List<AllProductDetailModel> deliveryList = [];

  Future fetchAllProducts() async {
    final firebase =
        await FirebaseFirestore.instance.collection('AllProduct').get();

    allproductList = firebase.docs
        .map((e) => AllProductDetailModel.fromMap(e.data()))
        .toList();

    // log(allproductList[0].toString());
  }

  Future fetchDeliveryProducts() async {
    final firebase =
        await FirebaseFirestore.instance.collection('AllProduct').get();

    deliveryList = firebase.docs
        .map((e) => AllProductDetailModel.fromMap(e.data()))
        .toList();

    // log(allproductList[0].toString());
  }

  Future<void> addProduct(
    String docid,
    int barcodeNumber,
    String itemcode,
    BuildContext context,
  ) async {
    final productdetails = AllProductDetailModel(
      unitcategoryID: unitCategoryTypeID.value,
      unitcategoryName: unitCategoryTypeName.value,
      addedDate: DateTime.now().toString(),
      isavailable: true,
      itemcode: itemcode,
      outofstock: false,
      subcategoryID: subCategoryTypeID.value,
      subcategoryName: subCategoryTypeName.value,
      companyName: brandnameController.text,
      inPrice: int.parse(inpriceController.text),
      returnType: '',
      packageType: Get.find<AddProductController>().packageTypeName.value,
      categoryID: Get.find<AddProductController>().recCatDocID.value,
      categoryName: Get.find<AddProductController>().recCatName.value,
      authuid: FirebaseAuth.instance.currentUser!.uid,
      docId: docid,
      barcodeNumber: barcodeNumber.toString(),
      productname: productnameController.text,
      quantityinStock: int.parse(quantityController.text.trim()),
      outPrice: int.parse(outpriceController.text.trim()),
      expiryDate: DateTime.now()
          .add(Duration(days: int.parse(expirydateController.text)))
          .toString(),
    );
    await FirebaseFirestore.instance
        .collection('AllProduct')
        .doc(docid)
        .set(productdetails.toMap())
        .then((value) => showToast(msg: 'Product Added'));
    productnameController.clear();
    outpriceController.clear();
    quantityController.clear();
    expirydateController.clear();
    Get.back();
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

  Future<void> checkProductAreSame(
      String docid, BuildContext context, String storeID) async {
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
            return RequestAddProduct(
              barcodeValue: docid,
              docid: storeID,
            );
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
      price: int.parse(outpriceController.text.trim()),
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
    outpriceController.clear();
    quantityController.clear();
    expirydateController.clear();

    Get.back();
  }

  Future<List<PackageTypeModel>> fetchPackagetypeModel() async {
    final firebase = await FirebaseFirestore.instance
        .collection('PackageTypeCollection')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => PackageTypeModel.fromMap(e.data())).toList();
      packageTypeModel.add(list[i]);
    }
    return packageTypeModel;
  }

  Future<List<SubCategoryModel>> fetchSubCategorytypeModel() async {
    final firebase =
        await FirebaseFirestore.instance.collection('Subcategory').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => SubCategoryModel.fromMap(e.data())).toList();
      subCategoryModel.add(list[i]);
    }
    return subCategoryModel;
  }

  Future<List<UnitCatModel>> fetchUnitCategorytypeModel() async {
    final firebase =
        await FirebaseFirestore.instance.collection('UnitCategory').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => UnitCatModel.fromMap(e.data())).toList();
      unitCategoryModel.add(list[i]);
    }
    return unitCategoryModel;
  }

  Future<void> updateStock(String docid, int currentvalue, int newvalue) async {
    int result = currentvalue + newvalue;

    FirebaseFirestore.instance
        .collection('AllProduct')
        .doc(docid)
        .update({'quantityinStock': result}).then((value) async {
      allproductList.clear();

      isloading.value = false;
      editqtyController.clear();
      showToast(msg: 'Stock updated');
      Get.back();
      await fetchAllProducts();
    });
  }

  @override
  void onInit() {
    fetchAllProducts();
    allproductList.clear();
    fetchDeliveryProducts();
    deliveryList.clear();

    super.onInit();
  }
}
