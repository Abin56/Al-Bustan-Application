import 'package:canteen_productadd_application/controller/calender_controller/calender_controller.dart';
import 'package:canteen_productadd_application/controller/search_product_controller/search_product_controller.dart';
import 'package:canteen_productadd_application/model/category_model/subcategory_model.dart';
import 'package:canteen_productadd_application/model/category_model/unit_type_model.dart';
import 'package:canteen_productadd_application/model/company_model/company_model.dart';
import 'package:canteen_productadd_application/model/packagetype_model.dart';
import 'package:canteen_productadd_application/model/product_category_model/product_category_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/navbar/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class WareHouseController extends GetxController {
  RxBool productuploading = false.obs;
  TextEditingController inpriceController = TextEditingController();
  TextEditingController outpriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController productlimitController = TextEditingController();
  TextEditingController expirydateController = TextEditingController();

  //webcopy//
  RxString productCategoryName = ''.obs;
  RxString productCategoryID = ''.obs;
  RxString productSubCategoryName = ''.obs;
  RxString productSubCategoryID = ''.obs;
  RxString productUnitName = ''.obs;
  RxString productUnitID = ''.obs;
  RxString productCompanyName = ''.obs;
  RxString productCompanyID = ''.obs;
  RxString productPackageName = ''.obs;
  RxString productPackageID = ''.obs;
  List<ProductCategoryModel> productCategoryList = [];
  List<ProductSubcategoryModel> productSubCategoryList = [];
  List<UnitCategoryModel> unitCategoryList = [];
  List<PackageTypeModel> packageTypeList = [];
  List<SuppliersModel> supplierList = [];
  TextEditingController quantityCtr = TextEditingController();
  //webcopy//

  Future<void> addProduct(
    String docid,
    int barcodeNumber,
    String itemcode,
    ProductAddingModel data,
    BuildContext context,
  ) async {
    try {
      final productdetails = ProductAddingModel(
          isEdit: false,
          limit: int.parse(productlimitController.text.trim()),
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
          expiryDate: Get.find<CalenderController>().date.value.toString()
          // expiryDate: DateTime.now()
          //     .add(Duration(days: int.parse(expirydateController.text)))
          //     .toString(),
          );
      await dataserver
          .collection('AllProductStockCollection')
          .doc(docid)
          .set(productdetails.toMap())
          .then((value) async {
        await dataserver
            .collection("AvailableProducts")
            .doc(docid)
            .set(productdetails.toMap());
      }).then((value) async {
        await dataserver
            .collection('TemporaryStockList')
            .doc(data.docId)
            .delete();
      }).then((value) async {
        Get.find<SearchProductController>().alltempProducts.clear();

        productuploading.value = false;
        Get.offAll(() => WareHouseAdminNavBar());

        outpriceController.clear();
        quantityController.clear();
        expirydateController.clear();
      });
      //     .then((value) => showToast(msg: 'Product Added'));
    } catch (e) {
      productuploading.value = false;
    }
  }

  Future<void> addProduct2(
    String docid,
    int barcodeNumber,
    String itemcode,
    ProductAddingModel data,
    BuildContext context,
  ) async {
    try {
      final productdetails = ProductAddingModel(
          isEdit: false,
          limit: int.parse(productlimitController.text.trim()),
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
          expiryDate: Get.find<CalenderController>().date.value.toString()
          // expiryDate: DateTime.now()
          //     .add(Duration(days: int.parse(expirydateController.text)))
          //     .toString(),
          );
      await dataserver
          .collection('AllProductStockCollection')
          .doc(docid)
          .set(productdetails.toMap())
          .then((value) async {
        await dataserver
            .collection("AvailableProducts")
            .doc(docid)
            .set(productdetails.toMap());
      }).then((value) async {
        await dataserver
            .collection('TemporaryStockList')
            .doc(data.docId)
            .delete();
      }).then((value) async {
        String id = const Uuid().v1();
        dataserver
            .collection("Storehistory")
            .doc(id)
            .set(productdetails.toMap())
            .then((value) {
          Get.find<SearchProductController>().alltempProducts.clear();

          productuploading.value = false;
          Get.offAll(() => WareHouseAdminNavBar());

          outpriceController.clear();
          quantityController.clear();
          expirydateController.clear();
        });
      });
      //     .then((value) => showToast(msg: 'Product Added'));
    } catch (e) {
      productuploading.value = false;
    }
  }

  // Arun //-------------
  Future<List<ProductCategoryModel>> fetchProductCategoryModel() async {
    final firebase = await dataserver.collection('ProductCategory').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs
          .map((e) => ProductCategoryModel.fromMap(e.data()))
          .toList();
      productCategoryList.add(list[i]);
    }
    return productCategoryList;
  }

  // productCategoryEdit(String text, String categoryId, String docId) async {
  //   final data = {'categoryName': text, 'categoryID': categoryId};

  //   await dataserver.collection('Stock').doc(docId).update(data).then((value) {
  //     showToast(msg: "Product category changed");
  //     // Get.back();
  //   });
  // }

  Future<List<ProductSubcategoryModel>> fetchProductSubCategoryModel() async {
    final firebase = await dataserver.collection('Subcategory').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs
          .map((e) => ProductSubcategoryModel.fromMap(e.data()))
          .toList();
      productSubCategoryList.add(list[i]);
    }
    return productSubCategoryList;
  }

  // productSubCategoryEdit(String text, String categoryId, String docId) async {
  //   final data = {'subcategoryName': text, 'subcategoryID': categoryId};

  //   await dataserver.collection('Stock').doc(docId).update(data).then((value) {
  //     showToast(msg: "Product subcategory changed");
  //     // Get.back();
  //   });
  // }

  Future<List<UnitCategoryModel>> fetchUnitCategoryModel() async {
    final firebase = await dataserver.collection('UnitCategory').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs
          .map((e) => UnitCategoryModel.fromMap(e.data()))
          .toList();
      unitCategoryList.add(list[i]);
    }
    return unitCategoryList;
  }

  // productUnitCategoryEdit(String text, String categoryId, String docId) async {
  //   final data = {'unitcategoryName': text, 'unitcategoryID': categoryId};

  //   await dataserver.collection('Stock').doc(docId).update(data).then((value) {
  //     showToast(msg: "Product unit category changed");
  //     // Get.back();
  //   });
  // }

  Future<List<PackageTypeModel>> fetchPackageTypeModel() async {
    final firebase = await dataserver.collection('PackageTypeCollection').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => PackageTypeModel.fromMap(e.data())).toList();
      packageTypeList.add(list[i]);
    }
    return packageTypeList;
  }

  // productPackageTypeEdit(String text, String categoryId, String docId) async {
  //   final data = {'packageType': text, 'packageTypeID': categoryId};

  //   await dataserver.collection('Stock').doc(docId).update(data).then((value) {
  //     showToast(msg: "Product Package type changed");
  //     // Get.back();
  //   });
  // }

  Future<List<SuppliersModel>> fetchSupplireModel() async {
    final firebase = await dataserver.collection('SuppliersList').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => SuppliersModel.fromMap(e.data())).toList();
      supplierList.add(list[i]);
    }
    return supplierList;
  }

  // productCompanyEdit(String text, String categoryId, String docId) async {
  //   final data = {'companyName': text, 'companyNameID': categoryId};

  //   await dataserver.collection('Stock').doc(docId).update(data).then((value) {
  //     showToast(msg: "Product Package type changed");
  //     // Get.back();
  //   });
  // }

  Future<void> editQuantity(
      String docid, int quantity, ProductAddingModel productData) async {
    dataserver
        .collection('AvailableProducts')
        .doc(docid)
        .update({'quantityinStock': quantity}).then((value) {
      String id = const Uuid().v1();
      String time = DateTime.now().toString();

      if (productData.quantityinStock < quantity) {
        int diffQuantity = quantity - productData.quantityinStock;
        String newProductName = "${productData.productname} (Manual)";

        ProductAddingModel data = ProductAddingModel(
            docId: id,
            barcodeNumber: productData.barcodeNumber,
            productname: newProductName,
            categoryID: productData.categoryID,
            categoryName: productData.categoryName,
            subcategoryID: productData.subcategoryID,
            subcategoryName: productData.subcategoryName,
            inPrice: productData.inPrice,
            outPrice: productData.outPrice,
            quantityinStock: diffQuantity,
            expiryDate: productData.expiryDate,
            addedDate: time,
            authuid: productData.authuid,
            unitcategoryID: productData.unitcategoryID,
            unitcategoryName: productData.unitcategoryName,
            packageType: productData.packageType,
            packageTypeID: productData.packageTypeID,
            companyName: productData.companyName,
            companyNameID: productData.companyNameID,
            returnType: productData.returnType,
            itemcode: productData.itemcode,
            outofstock: productData.outofstock,
            isavailable: productData.isavailable,
            isEdit: productData.isEdit,
            limit: productData.limit);
        dataserver
            .collection('Storehistory')
            .doc(id)
            .set(data.toMap())
            .then((value) {
          showToast(msg: "quantity updated");
          Get.back();
        });
      } else if (productData.quantityinStock == quantity) {
        showToast(msg: "quantity updated");
        Get.back();
      } else {
        int diffQuantity = quantity - productData.quantityinStock;
        String newProductName = "${productData.productname} (Manual)";

        ProductAddingModel data = ProductAddingModel(
            docId: id,
            barcodeNumber: productData.barcodeNumber,
            productname: newProductName,
            categoryID: productData.categoryID,
            categoryName: productData.categoryName,
            subcategoryID: productData.subcategoryID,
            subcategoryName: productData.subcategoryName,
            inPrice: productData.inPrice,
            outPrice: productData.outPrice,
            quantityinStock: diffQuantity,
            expiryDate: productData.expiryDate,
            addedDate: time,
            authuid: productData.authuid,
            unitcategoryID: productData.unitcategoryID,
            unitcategoryName: productData.unitcategoryName,
            packageType: productData.packageType,
            packageTypeID: productData.packageTypeID,
            companyName: productData.companyName,
            companyNameID: productData.companyNameID,
            returnType: productData.returnType,
            itemcode: productData.itemcode,
            outofstock: productData.outofstock,
            isavailable: productData.isavailable,
            isEdit: productData.isEdit,
            limit: productData.limit);
        dataserver
            .collection('Storehistory')
            .doc(id)
            .set(data.toMap())
            .then((value) {
          showToast(msg: "quantity updated");
          Get.back();
        });
      }
    });
  }
}
