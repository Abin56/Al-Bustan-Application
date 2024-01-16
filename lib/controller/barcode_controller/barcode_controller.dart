import 'dart:developer';

import 'package:get/get.dart';

class BarcodeController extends GetxController {
  RxString barcodevalue = ''.obs;

  Future<void> barcodescanResult(String res) async {
    barcodevalue.value = res;
    log("Barcode value == ${barcodevalue.value}");
  }
}
