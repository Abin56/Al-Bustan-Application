import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';
import 'package:canteen_productadd_application/model/delivery/deliveryProduct_model/deliveryproduct_model.dart';
import 'package:canteen_productadd_application/model/delivery/view_delivery_orders.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/invoice_pdf/get_invoice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  RxBool signIsLoading = false.obs;
  Future<void> pickedItem(String deliverydocid, String itemdocid,
      DeliveryProductListModel deliveryProductListModel) async {
    await FirebaseFirestore.instance
        .collection('AllUsersCollection')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DeliveryRequest')
        .doc(deliverydocid)
        .collection('productsDetails')
        .doc(itemdocid)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('AllUsersCollection')
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
      DeliveryOrdersModel deliveryOrdersModel, BuildContext context) async {
    FirebaseFirestore.instance
        .collection('AllUsersCollection')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DeliveryRequest')
        .doc(deliverydocid)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('AllUsersCollection')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("DeliveryHistory")
          .doc(deliveryOrdersModel.orderId)
          .set(deliveryOrdersModel.toMap(), SetOptions(merge: true))
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("DeliveryHistory")
            .doc(deliveryOrdersModel.orderId)
            .update({'deliveredtime': DateTime.now().toString()});
        await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("DeliveryHistory")
            .doc(deliveryOrdersModel.orderId)
            .update({'signURl': signUrl}).then((value) async {
          await FirebaseFirestore.instance
              .collection('deliveryAssignList')
              .doc(deliverydocid)
              .update({'isDelivered': true}).then((value) async {
            signIsLoading.value = false;
            Get.back();
            showToast(msg: "Delivered");
            await generateInvoice(context);
          });
        });
      });
    });
  }

///////////////////////////////////////////////////////////////////Arun////////////////////////////////

  deliverdsign2(String signUrl, String deliverydocid,
      DeliveryOrdersModel deliveryOrdersModel, BuildContext context) async {
    FirebaseFirestore.instance
        .collection('AllUsersCollection')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DeliveryRequest')
        .doc(deliverydocid)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('AllUsersCollection')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("DeliveryHistory")
          .doc(deliveryOrdersModel.orderId)
          .set(deliveryOrdersModel.toMap(), SetOptions(merge: true))
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("DeliveryHistory")
            .doc(deliveryOrdersModel.orderId)
            .update({'deliveredtime': DateTime.now().toString()});
        await FirebaseFirestore.instance
            .collection('AllUsersCollection')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("DeliveryHistory")
            .doc(deliveryOrdersModel.orderId)
            .update({'signURl': signUrl}).then((value) async {
          // data getting from picked collectiona and set to deleivered collection //
          final pickedData = await dataserver
              .collection('DeliverypickedupList')
              .doc(deliverydocid)
              .get();
          await dataserver
              .collection('DeliveredList')
              .doc(deliverydocid)
              .set(pickedData.data()!);

          // updating the Delivered list //

          await dataserver
              .collection('DeliveredList')
              .doc(deliverydocid)
              .update({'isDelivered': true, 'statusMessage': "Delivered"});

// Adding teh product list in delivered collection//
          final productDetailsList = await dataserver
              .collection('DeliverypickedupList')
              .doc(deliverydocid)
              .collection('productsDetails')
              .get();

          final productlist = productDetailsList.docs
              .map((e) => AllProductDetailModel.fromMap(e.data()))
              .toList();
          for (AllProductDetailModel data in productlist) {
            await dataserver
                .collection('DeliveredList')
                .doc(deliverydocid)
                .collection('productsDetails')
                .doc(data.docId)
                .set(data.toMap());
          }

          // after adding the picked up details deleted and added to delivery history //

          await dataserver
              .collection('DeliverypickedupList')
              .doc(deliverydocid)
              .delete()
              .then((value) async {
            signIsLoading.value = false;
            Get.back();
            showToast(msg: "Delivered");
            await generateInvoice(context);
          });

          // await FirebaseFirestore.instance
          //     .collection('deliveryAssignList')
          //     .doc(deliverydocid)
          //     .update({'isDelivered': true}).then((value) async {
          //   signIsLoading.value = false;
          //   Get.back();
          //   showToast(msg: "Delivered");
          //   await generateInvoice(context);
          // });
        });
      });
    });
  }

  Future<void> pickedItem2(String deliverydocid, String itemdocid,
      DeliveryProductListModel deliveryProductListModel) async {
    await FirebaseFirestore.instance
        .collection('AllUsersCollection')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('DeliveryRequest')
        .doc(deliverydocid)
        .collection('productsDetails')
        .doc(itemdocid)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('AllUsersCollection')
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

// checking product details avail or not if avail still pending otherwise the order become picked up//
      final checkData = await dataserver
          .collection('AllUsersCollection')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('DeliveryRequest')
          .doc(deliverydocid)
          .collection('productsDetails')
          .get();
      if (checkData.docs.isEmpty) {
        final pendingData = await dataserver
            .collection('DeliveryPendingList')
            .doc(deliverydocid)
            .get();
        await dataserver
            .collection('DeliverypickedupList')
            .doc(deliverydocid)
            .set(pendingData.data()!);

        // updating the picked up list //
        final pickedData = {
          'pickedUpStatus': true,
          'statusMessage': "Picked Up"
        };
        await dataserver
            .collection('DeliverypickedupList')
            .doc(deliverydocid)
            .update(pickedData);

        final productDetailsList = await dataserver
            .collection('DeliveryPendingList')
            .doc(deliverydocid)
            .collection('productsDetails')
            .get();
// Adding teh product list in deliveryPicked up collection//
        final productlist = productDetailsList.docs
            .map((e) => AllProductDetailModel.fromMap(e.data()))
            .toList();
        for (AllProductDetailModel data in productlist) {
          await dataserver
              .collection('DeliverypickedupList')
              .doc(deliverydocid)
              .collection('productsDetails')
              .doc(data.docId)
              .set(data.toMap());
        }
        // deleting the delivery pending list//
        await dataserver
            .collection('DeliveryPendingList')
            .doc(deliverydocid)
            .delete();
      }
    });
  }
}
