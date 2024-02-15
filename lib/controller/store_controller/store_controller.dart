import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  allProductAddToLowStockAlert() async {
    try {
      final availableProductList = await getAvailableProductList();

      for (ProductAddingModel data in availableProductList) {
        if (data.quantityinStock <= data.limit) {
          dataserver
              .collection('LowStockAlert')
              .doc(data.docId)
              .set(data.toMap());
        }
      }
    } catch (e) {
      showToast(msg: 'Error occure in all product low stock checking ');
    }
  }

  Future<List<ProductAddingModel>> getAvailableProductList() async {
    final avilableStockData =
        await dataserver.collection('AvailableProducts').get();

    final availableProdcutList = avilableStockData.docs
        .map((e) => ProductAddingModel.fromMap(e.data()))
        .toList();
    return availableProdcutList;
  }
}
