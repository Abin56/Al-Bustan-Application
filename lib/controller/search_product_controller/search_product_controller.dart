import 'dart:developer';

import 'package:canteen_productadd_application/model/company_model/company_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  RxBool dropdown = false.obs;
  RxString companyName = ''.obs;
  List<SuppliersModel> allCompayList = [];
  List<ProductAddingModel> alltempProducts = [];
  Future<void> fetchallTempProducts() async {
    try {
      final result = await dataserver.collection('TemporaryStockList').get();
      alltempProducts =
          result.docs.map((e) => ProductAddingModel.fromMap(e.data())).toList();
    } catch (e) {
      showToast(msg: "All Product Error");
      log(e.toString());
    }
  }

  Future<List<SuppliersModel>> fetchallCompany() async {
    final firebase = await dataserver.collection('SuppliersList').get();
    try {
      for (var i = 0; i < firebase.docs.length; i++) {
        final list =
            firebase.docs.map((e) => SuppliersModel.fromMap(e.data())).toList();
        allCompayList.add(list[i]);
      }
    } catch (e) {
      showToast(msg: " Error");
      log(e.toString());
    }
    return allCompayList;
  }

  @override
  void onInit() async {
    await fetchallTempProducts();
    await fetchallCompany();
    super.onInit();
  }
}
