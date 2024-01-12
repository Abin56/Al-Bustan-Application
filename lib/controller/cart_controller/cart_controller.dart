import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';
import 'package:canteen_productadd_application/model/cart_model/cart_model.dart';
import 'package:canteen_productadd_application/model/user_model/user_model.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  addToEmployeeCart({required AllProductDetailModel data}) async {
    final uuid = Uuid().v1();
    final cartdata = {
      "productDetailsDocId": data.docId,
      "barcodeNumber": data.barcodeNumber,
      "productname": data.productname,
      "availableQuantity": data.quantityinStock,
      "inPrice": data.inPrice,
      "outPrice": data.outPrice,
      "quantity": 0,
      "totalAmount": 0,
      "docId": uuid
    };
    await firestore
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .collection("cart")
        .doc(uuid)
        .set(cartdata)
        .then((value) {
      showToast(msg: 'Prodect Added to Cart');
    });
    //product added to single employee list for getting all product details//
    await firestore
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .collection("EmployeeCartProductDetails")
        .doc(data.docId)
        .set(data.toMap());

    //product quantity set zero//
    await firestore
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .collection("EmployeeCartProductDetails")
        .doc(data.docId)
        .update({'quantityinStock': 0});
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
          .collection('EmployeeProfile')
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(data.docId)
          .update(qtydata);
      firestore
          .collection('EmployeeProfile')
          .doc(auth.currentUser!.uid)
          .collection("EmployeeCartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Maximum quantity added");
    }
  }

  lessQuantity(CartModel data) {
    if (data.quantity > 0) {
      int qty = data.quantity - 1;
      int totalAmount = data.outPrice * qty;
      final qtydata = {
        'totalAmount': totalAmount,
        'quantity': qty,
      };
      firestore
          .collection('EmployeeProfile')
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(data.docId)
          .update(qtydata);
      firestore
          .collection('EmployeeProfile')
          .doc(auth.currentUser!.uid)
          .collection("EmployeeCartProductDetails")
          .doc(data.productDetailsDocId)
          .update({'quantityinStock': qty});
    } else {
      showToast(msg: "Please add quantity");
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
          .collection('EmployeeProfile')
          .doc(auth.currentUser!.uid)
          .collection("cart")
          .doc(data.docId)
          .update(qtydata);
      firestore
          .collection('EmployeeProfile')
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
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .collection('cart')
        .get();
    if (singleEmployeeCartList.docs.isNotEmpty) {
      int amount = 0;
      String id = idGenerator();
      final orderid = '#' + id;
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
                .collection('EmployeeProfile')
                .doc(auth.currentUser!.uid)
                .collection('cart')
                .doc(cartdetailsList[i].docId)
                .delete();
            firestore
                .collection('EmployeeProfile')
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
      final requestId = 'RQ' + id;

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
        "employeeId": auth.currentUser!.uid
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
              .collection('EmployeeProfile')
              .doc(auth.currentUser!.uid)
              .collection('cart')
              .doc(singleEmployeeCartList[i].docId)
              .delete();
          firestore
              .collection('EmployeeProfile')
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
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .collection('cart')
        .get();
    return data.docs.map((e) => CartModel.fromMap(e.data())).toList();
  }

  Future<List<AllProductDetailModel>>
      getEmployeeCartProductDetailsList() async {
    final data = await firestore
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .collection('EmployeeCartProductDetails')
        .get();
    return data.docs
        .map((e) => AllProductDetailModel.fromMap(e.data()))
        .toList();
  }

  Future<String> getCurrentEmplyeeName() async {
    final data = await firestore
        .collection('EmployeeProfile')
        .doc(auth.currentUser!.uid)
        .get();
    String name = data["name"];
    return name;
  }
}
