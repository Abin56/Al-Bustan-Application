import 'package:canteen_productadd_application/model/delivery/deliveryProduct_model/deliveryproduct_model.dart';
import 'package:canteen_productadd_application/model/delivery/view_delivery_orders.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  Future<void> pickedItem(String deliverydocid, String itemdocid,
      DeliveryProductListModel deliveryProductListModel) async {
    await FirebaseFirestore.instance
        .collection('EmployeeProfile')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DeliveryRequest')
        .doc(deliverydocid)
        .collection('productsDetails')
        .doc(itemdocid)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('EmployeeProfile')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('DeliveryHistory')
          .doc(deliverydocid)
          .collection('ProductItems')
          .doc(deliveryProductListModel.docId)
          .set(deliveryProductListModel.toMap());
      Get.back();
      Get.back();
      Get.back();
      showToast(msg: 'item picked');
    });
  }

  deliverdsign(String signUrl, String deliverydocid,
      DeliveryOrdersModel deliveryOrdersModel) async {
    FirebaseFirestore.instance
        .collection('EmployeeProfile')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DeliveryRequest')
        .doc(deliverydocid)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('EmployeeProfile')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("DeliveryHistory")
          .doc(deliveryOrdersModel.orderId)
          .set(deliveryOrdersModel.toMap(), SetOptions(merge: true))
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('EmployeeProfile')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("DeliveryHistory")
            .doc(deliveryOrdersModel.orderId)
            .update({'signURl': signUrl}).then((value) async {
          await FirebaseFirestore.instance
              .collection('deliveryAssignList')
              .doc(deliverydocid)
              .update({'isDelivered': true});
        });
      });

      Get.back();
      showToast(msg: "Delivered");
    });
  }
}
