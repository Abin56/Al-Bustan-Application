import 'package:canteen_productadd_application/model/admin_model/admin_model.dart';
import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';
import 'package:canteen_productadd_application/model/canteen_model/canteen_model.dart';
import 'package:canteen_productadd_application/model/cart_model/cart_model.dart';
import 'package:canteen_productadd_application/model/delivery/deliveryProduct_model/deliveryproduct_model.dart';
import 'package:canteen_productadd_application/model/delivery/view_delivery_orders.dart';
import 'package:canteen_productadd_application/model/employee_request_model/employee_request_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/invoice_pdf/get_invoice.dart';
import 'package:canteen_productadd_application/view/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  RxBool signIsLoading = false.obs;
  List<AdminModel> employeeList = [];
  RxString employeeUID = ''.obs;
  String employeeName = '';

  RxString canteenName = ''.obs;
  RxString canteenID = ''.obs;
  List<CanteenModel> canteenList = [];

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

      // after picked up the product count deducted from the available product //

      final availStockdetails = await dataserver
          .collection('AvailableProducts')
          .doc(deliveryProductListModel.docId)
          .get();
      final availStockModel =
          ProductAddingModel.fromMap(availStockdetails.data()!);
      final availablQty = availStockModel.quantityinStock -
          deliveryProductListModel.quantityinStock;

      dataserver
          .collection('AvailableProducts')
          .doc(deliveryProductListModel.docId)
          .update({'quantityinStock': availablQty});

      //after qty deduct the actual qty compare with with limit and add to stock alert //

      singleproductAddToLowStockAlert(availablQty,
          deliveryProductListModel.limit, deliveryProductListModel);

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

  singleproductAddToLowStockAlert(
      int CurrentStockCount, int margin, DeliveryProductListModel product) {
    //single product add to low stock alter collection //
    if (CurrentStockCount <= margin) {
      dataserver
          .collection('LowStockAlert')
          .doc(product.docId)
          .set(product.toMap());
    }
  }

  confirmEmployeeRequest(EmployeeRequestModel requestdata) async {
    String id = idGenerator();
    final orderid = '#$id';

    final data = {
      'time': requestdata.time,
      "docId": orderid,
      "orderCount": requestdata.orderCount,
      "orderId": orderid,
      "assignStatus": false,
      "isDelivered": false,
      "pendingStatus": false,
      "pickedUpStatus": false,
      "statusMessage": "",
      "price": requestdata.amount,
      "employeeName": requestdata.emplopeeName,
      "employeeId": requestdata.emplopeeId,
      "canteenName": requestdata.canteenName,
      "canteenId": requestdata.canteenId,
    };
    final requestedProductList = await dataserver
        .collection('EmployeeDeliveryRequest')
        .doc(requestdata.docid)
        .collection('RequestProductDetails')
        .get();
    for (var element in requestedProductList.docs) {
      dataserver
          .collection("deliveryAssignList")
          .doc(orderid)
          .collection('orderProducts')
          .doc(element['docId'])
          .set(element.data());
    }
    dataserver.collection("deliveryAssignList").doc(orderid).set(data);
    showToast(msg: "Delivery Request added");
    Get.back();
    //delete after request confirm//
    final employeeProductList = await dataserver
        .collection('EmployeeDeliveryRequest')
        .doc(requestdata.docid)
        .collection('RequestProductDetails')
        .get();
    for (var element in employeeProductList.docs) {
      dataserver
          .collection('EmployeeDeliveryRequest')
          .doc(requestdata.docid)
          .collection('RequestProductDetails')
          .doc(element['docId'])
          .delete();
    }
    dataserver
        .collection('EmployeeDeliveryRequest')
        .doc(requestdata.docid)
        .delete();
  }

  Future<List<AdminModel>> fetchEmployeeModel() async {
    final firebase =
        await FirebaseFirestore.instance.collection('AllUsersCollection').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      // final list =
      //     firebase.docs.map((e) => AdminModel.fromMap(e.data())).toList();
      // employeeList.add(list[i]);
      final list =
          firebase.docs.map((e) => AdminModel.fromMap(e.data())).toList();
      if (list[i].userrole == 'employee') {
        employeeList.add(list[i]);
      }
    }
    return employeeList;
  }

  createDeliveryAssignToEmployee(
      //assigning function//
      //for creating request to employee by assigning//
      {required String employeeName,
      required String employeeId,
      required DocumentSnapshot deliverydata}) async {
    final time = DateTime.now().toString();

    //delivery request goes to pending list //
    final pendingData = {
      'time': time,
      "docId": deliverydata['orderId'],
      "orderCount": deliverydata['orderCount'],
      "orderId": deliverydata['orderId'],
      "assignStatus": true,
      "isDelivered": false,
      "pendingStatus": true,
      "pickedUpStatus": false,
      "statusMessage": "Pending",
      "price": deliverydata['price'],
      "employeeName": employeeName,
      "employeeId": employeeId,
      "canteenName": deliverydata["canteenName"],
      "canteenId": deliverydata["canteenId"]
    };
    await dataserver
        .collection("DeliveryPendingList")
        .doc(deliverydata['orderId'])
        .set(pendingData);

    //employees details//
    // final employeeData = {
    //   "employeeName": employeeName,
    //   "employeeId": employeeId,
    //   'assignStatus': true
    // };
    //employees details updated in delivery request detilas//
    // await firestore
    //     .collection('deliveryAssignList')
    //     .doc(deliverydata['orderId'])
    //     .update(employeeData);

    //delivery details//
    final data = {
      'orderId': deliverydata['orderId'],
      'orderCount': deliverydata['orderCount'],
      'time': time,
      'status': 'Pending'
    };

    //delivery request details stored in employees collection//
    await dataserver
        .collection('AllUsersCollection')
        .doc(employeeId)
        .collection(('DeliveryRequest'))
        .doc(deliverydata['orderId'])
        .set(data);
    //for getting product detials list from deliveryAssignList collection//
    final productDetailsList = await dataserver
        .collection('deliveryAssignList')
        .doc(deliverydata['orderId'])
        .collection('orderProducts')
        .get();
    //converted into product model//
    final productlist = productDetailsList.docs
        .map((e) => AllProductDetailModel.fromMap(e.data()))
        .toList();
    //for add product details in employees collection//
    for (int i = 0; i < productlist.length; i++) {
      await dataserver
          .collection('AllUsersCollection')
          .doc(employeeId)
          .collection(('DeliveryRequest'))
          .doc(deliverydata['orderId'])
          .collection("productsDetails")
          .doc(productlist[i].docId)
          .set(productlist[i].toMap());

      await dataserver
          .collection('DeliveryPendingList')
          .doc(deliverydata['orderId'])
          .collection("productsDetails")
          .doc(productlist[i].docId)
          .set(productlist[i].toMap());
    }

    await dataserver
        .collection('deliveryAssignList')
        .doc(deliverydata['orderId'])
        .delete();
  }

  addQuantity(CartModel data) {
    if (data.quantity < data.availablequantityinStock) {
      int qty = data.quantity + 1;
      int totalAmount = data.outPrice * qty;
      final qtydata = {
        'totalAmount': totalAmount,
        'quantity': qty,
      };
      dataserver.collection('DeliveryCart').doc(data.docId).update(qtydata);

      dataserver
          .collection('DeliveryCart')
          .doc(data.docId)
          .collection("CartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Maximum quantity added");
    }
  }

  lessQuantity(CartModel data) {
    if (data.quantity > 1) {
      int qty = data.quantity - 1;
      int totalAmount = data.outPrice * qty;
      final qtydata = {
        'totalAmount': totalAmount,
        'quantity': qty,
      };
      dataserver.collection('DeliveryCart').doc(data.docId).update(qtydata);
      dataserver
          .collection('DeliveryCart')
          .doc(data.docId)
          .collection("CartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Minimum 1 quantity needed");
    }
  }

  onChangeFuction(CartModel data, String value) {
    final qty = int.parse(value);
    int totalAmount = data.outPrice * qty;
    if (qty > 0 && qty <= data.availablequantityinStock) {
      final qtydata = {
        'totalAmount': totalAmount,
        'quantity': qty,
      };
      dataserver.collection('DeliveryCart').doc(data.docId).update(qtydata);
      dataserver
          .collection('DeliveryCart')
          .doc(data.docId)
          .collection("CartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Please enter valid quantity");
    }
  }

  addToCart(ProductAddingModel data) {
    // final uuid = Uuid().v1();
    final cartdata = {
      "productDetailsDocId": data.docId,
      "barcodeNumber": data.barcodeNumber,
      "productname": data.productname,
      "availableQuantity": data.quantityinStock,
      "inPrice": data.inPrice,
      "outPrice": data.outPrice,
      "quantity": 1,
      "totalAmount": data.outPrice,
      "docId": data.docId
    };

    dataserver.collection("DeliveryCart").doc(data.docId).set(cartdata).then(
      (value) {
        showToast(msg: "Added to Cart");
      },
    );
    dataserver
        .collection('DeliveryCart')
        .doc(data.docId)
        .collection("CartProductDetails")
        .doc(data.docId)
        .set(data.toMap());
    dataserver
        .collection('DeliveryCart')
        .doc(data.docId)
        .collection("CartProductDetails")
        .doc(data.docId)
        .update({'quantityinStock': 0});
  }

  deleteCartItem(String docId) {
    dataserver.collection('DeliveryCart').doc(docId).delete().then((value) {
      showToast(msg: "Item Deleted from cart");
    });
  }

  Future<List<CanteenModel>> fetchcanteenModel() async {
    final firebase =
        await FirebaseFirestore.instance.collection('CanteenList').get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list =
          firebase.docs.map((e) => CanteenModel.fromMap(e.data())).toList();
      canteenList.add(list[i]);
    }
    return canteenList;
  }

  cartToDeliveryOrder() async {
    //for getting count of cart details if cark empty the request not add//
    final cartlistLength = await dataserver.collection('DeliveryCart').get();
    if (cartlistLength.docs.isNotEmpty) {
      int amount = 0;
      String id = idGenerator();
      final orderid = '#$id';
      final cartProductS =
          await dataserver.collectionGroup('CartProductDetails').get();
      final cartProductsList = cartProductS.docs
          .map((e) => AllProductDetailModel.fromMap(e.data()))
          .toList();
      //product details added to deliveryAssignList collection//
      for (int i = 0; i < cartProductsList.length; i++) {
        // final uuid2 = const Uuid().v1();
        dataserver
            .collection("deliveryAssignList")
            .doc(orderid)
            .collection("orderProducts")
            .doc(cartProductsList[i].docId)
            .set(cartProductsList[i].toMap());
      }
      //for getting time//
      final time = DateTime.now().toString();
      //for getting cart details //
      final cartdetailsList = await getCartList();
      // after getting cart details the amount added for getting total amount//
      for (var element in cartdetailsList) {
        amount = amount + element.totalAmount;
      }

      final data = {
        'time': time,
        "docId": orderid,
        "orderCount": cartProductsList.length,
        "orderId": orderid,
        "assignStatus": false,
        "isDelivered": false,
        "pendingStatus": false,
        "pickedUpStatus": false,
        "statusMessage": "Pending",
        "price": amount,
        "employeeName": '',
        "employeeId": '',
        "canteenName": canteenName.value,
        "canteenId": canteenID.value
      };
      //for adding delivery deatils in deliveryAssignlist collection//
      dataserver.collection("deliveryAssignList").doc(orderid).set(data);
      showToast(msg: "Delivery Request added");
      Get.back();
      //for deleting cart details after making delivery request//
      for (int i = 0; i < cartdetailsList.length; i++) {
        dataserver
            .collection('DeliveryCart')
            .doc(cartdetailsList[i].docId)
            .collection('CartProductDetails')
            .doc(cartdetailsList[i].productDetailsDocId)
            .delete();
        dataserver
            .collection('DeliveryCart')
            .doc(cartdetailsList[i].docId)
            .delete();
      }
    } else {
      showToast(msg: "Please Add Product");
    }
  }

  Future<List<CartModel>> getCartList() async {
    final data = await dataserver.collection('DeliveryCart').get();
    return data.docs.map((e) => CartModel.fromMap(e.data())).toList();
  }
}
