import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';
import 'package:canteen_productadd_application/model/canteen_model/canteen_model.dart';
import 'package:canteen_productadd_application/model/cart_model/cart_model.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/core/core.dart';
import 'package:canteen_productadd_application/view/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxString canteenName = ''.obs;
  RxString canteenID = ''.obs;
  List<CanteenModel> canteenList = [];

  addToEmployeeCart({required ProductAddingModel data}) async {
    // final uuid = const Uuid().v1();
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
    await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc(data.docId)
        .set(cartdata)
        .then((value) {
      showToast(msg: 'Prodect Added to Cart');
    });
    //product added to single employee list for getting all product details//
    await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection("EmployeeCartProductDetails")
        .doc(data.docId)
        .set(data.toMap());

    //product quantity set zero//
    await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection("EmployeeCartProductDetails")
        .doc(data.docId)
        .update({'quantityinStock': 1});
  }

  addQuantity(CartModel data) {
    if (data.quantity < data.availablequantityinStock) {
      int qty = data.quantity + 1;
      int totalAmount = data.outPrice * qty;
      final qtydata = {
        'totalAmount': totalAmount,
        'quantity': qty,
      };
      firestore
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(data.docId)
          .update(qtydata);
      firestore
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection("EmployeeCartProductDetails")
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
      firestore
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(data.docId)
          .update(qtydata);
      firestore
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection("EmployeeCartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Minimum 1 quantity required");
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
      firestore
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(data.docId)
          .update(qtydata);
      firestore
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection("EmployeeCartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Please enter valid quantity");
    }
  }

  //cartToRequestDeliveryOrder() not using //

  cartToRequestDeliveryOrder() async {
    //for getting single employee cart item count //
    final singleEmployeeCartList = await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection('cart')
        .get();
    if (singleEmployeeCartList.docs.isNotEmpty) {
      int amount = 0;
      String id = idGenerator();
      final orderid = '#$id';
      final employeescartProductSList =
          await getEmployeeCartProductDetailsList();

      for (int i = 0; i < employeescartProductSList.length; i++) {
        final uuid2 = const Uuid().v1();
        firestore
            .collection("deliveryAssignList")
            .doc(orderid)
            .collection("orderProducts")
            .doc(uuid2)
            .set(employeescartProductSList[i].toMap());
      }

      final time = DateTime.now().toString();

      final cartdetailsList = await getEmployeeCartList();

      for (var element in cartdetailsList) {
        amount = amount + element.totalAmount;
      }

      final data = {
        'time': time,
        "docId": orderid,
        "orderCount": employeescartProductSList.length,
        "orderId": orderid,
        "assignStatus": false,
        "isDelivered": false,
        "pendingStatus": false,
        "pickedupstatus": false,
        "statusMessage": "",
        "price": amount,
        "employeeName": '',
        "employeeId": ''
      };
      firestore.collection("deliveryAssignList").doc(orderid).set(data).then(
        (value) {
          showToast(msg: "Delivery Request added");
          Get.back();
          //after requset made the cart list will deleted//

          for (int i = 0; i < cartdetailsList.length; i++) {
            firestore
                .collection('AllUsersCollection')
                .doc(auth.currentUser!.uid)
                .collection('cart')
                .doc(cartdetailsList[i].docId)
                .delete();
            firestore
                .collection('AllUsersCollection')
                .doc(auth.currentUser!.uid)
                .collection('EmployeeCartProductDetails')
                .doc(cartdetailsList[i].productDetailsDocId)
                .delete();
          }
        },
      );
    } else {
      showToast(msg: "Please add product");
    }
  }

  addEmployeeRequest() async {
    //for getting single employee cart item count //
    final singleEmployeeCartList = await getEmployeeCartList();
    if (singleEmployeeCartList.isNotEmpty) {
      int amount = 0;
      String id = idGenerator();
      String time = DateTime.now().toString();
      final requestId = 'RQ$id';

      for (var element in singleEmployeeCartList) {
        amount = amount + element.totalAmount;
      }

      final productList = await getEmployeeCartProductDetailsList();

      for (int i = 0; i < productList.length; i++) {
        await firestore
            .collection('EmployeeDeliveryRequest')
            .doc(requestId)
            .collection('RequestProductDetails')
            .doc(productList[i].docId)
            .set(
              productList[i].toMap(),
            );
      }

      String employeeName = await getCurrentEmplyeeName();

      final requestData = {
        "docid": requestId,
        "time": time,
        "orderCount": singleEmployeeCartList.length,
        "amount": amount,
        "requestId": requestId,
        "employeeName": employeeName,
        "employeeId": auth.currentUser!.uid,
        "canteenName": canteenName.value,
        "canteenId": canteenID.value,
      };

      await firestore
          .collection("EmployeeDeliveryRequest")
          .doc(requestId)
          .set(requestData)
          .then((value) {
        showToast(msg: "Delivery Request added");
        Get.back();
        for (int i = 0; i < singleEmployeeCartList.length; i++) {
          firestore
              .collection('AllUsersCollection')
              .doc(auth.currentUser!.uid)
              .collection('cart')
              .doc(singleEmployeeCartList[i].docId)
              .delete();
          firestore
              .collection('AllUsersCollection')
              .doc(auth.currentUser!.uid)
              .collection('EmployeeCartProductDetails')
              .doc(singleEmployeeCartList[i].productDetailsDocId)
              .delete();
        }
      });
    } else {
      showToast(msg: "Please add product");
    }
  }

  Future<List<CartModel>> getEmployeeCartList() async {
    final data = await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection('cart')
        .get();
    return data.docs.map((e) => CartModel.fromMap(e.data())).toList();
  }

  Future<List<ProductAddingModel>> getEmployeeCartProductDetailsList() async {
    final data = await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection('EmployeeCartProductDetails')
        .get();
    return data.docs.map((e) => ProductAddingModel.fromMap(e.data())).toList();
  }

  Future<String> getCurrentEmplyeeName() async {
    final data = await firestore
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .get();
    String name = data["name"];
    return name;
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

  removeItemFromCart(String docid) {
    dataserver
        .collection('AllUsersCollection')
        .doc(auth.currentUser!.uid)
        .collection('cart')
        .doc(docid)
        .delete()
        .then((value) {
      dataserver
          .collection('AllUsersCollection')
          .doc(auth.currentUser!.uid)
          .collection('EmployeeCartProductDetails')
          .doc(docid)
          .delete()
          .then((value) {
        showToast(msg: "Item removed from cart");
      });
    });
  }
}
