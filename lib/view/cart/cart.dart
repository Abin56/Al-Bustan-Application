import 'package:canteen_productadd_application/controller/cart_controller/cart_controller.dart';
import 'package:canteen_productadd_application/model/cart_model/cart_model.dart';
import 'package:canteen_productadd_application/view/all_product_list/all_product_screen.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  CartWidget({super.key});

  final cartCtr = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GooglePoppinsWidgets(text: "Cart", fontsize: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('EmployeeProfile')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child:
                          GooglePoppinsWidgets(text: "No data", fontsize: 15),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child:
                          GooglePoppinsWidgets(text: "No data", fontsize: 15),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        List<TextEditingController> controllers = List.generate(
                          snapshot.data!.docs.length,
                          (index) => TextEditingController(),
                        );
                        final cartData = CartModel.fromMap(
                            snapshot.data!.docs[index].data());
                        controllers[index].text = cartData.quantity.toString();
                        return Container(
                          decoration: BoxDecoration(
                            color: cWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: cGrey,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(2.0, 2.0),
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(-1.0, -1.0),
                                blurRadius: 8.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'images/Al_bustan.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GooglePoppinsWidgets(
                                          text: cartData.productname,
                                          fontsize: 14),
                                      GooglePoppinsWidgets(
                                        text:
                                            "Available Qty : ${cartData.availablequantityinStock}",
                                        fontsize: 14,
                                        color: cGrey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              cartCtr.lessQuantity(cartData);
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: cGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: GooglePoppinsWidgets(
                                                    text: '-', fontsize: 16),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SizedBox(
                                              height: 30,
                                              width: 70,
                                              child: TextField(
                                                controller: controllers[index],
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  cartCtr.onChangeFuction(
                                                      cartData, value);
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cartCtr.addQuantity(cartData);
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: cGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: GooglePoppinsWidgets(
                                                    text: '+', fontsize: 16),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: GooglePoppinsWidgets(
                                        text: cartData.totalAmount.toString(),
                                        fontsize: 15),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return sh10;
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        surfaceTintColor: cWhite,
        child: GestureDetector(
          onTap: () {
            cartCtr.cartToRequestDeliveryOrder();
          },
          child: Container(
            width: double.infinity,
            height: 10,
            color: cGreen,
            child: Center(
                child: GooglePoppinsWidgets(
              text: "Add Request",
              fontsize: 16,
              color: cWhite,
            )),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     cartCtr.cartToRequestDeliveryOrder();
      //   },
      //   label: GooglePoppinsWidgets(
      //     text: "Add Request",
      //     fontsize: 16,
      //   ),
      // ),
    );
  }
}

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.cartdata,
  });
  final CartModel cartdata;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: cGrey,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(2.0, 2.0),
            blurRadius: 6.0,
            spreadRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(-1.0, -1.0),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                        image: AssetImage('images/Al_bustan.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GooglePoppinsWidgets(
                      text: cartdata.productname, fontsize: 14),
                  GooglePoppinsWidgets(
                    text:
                        "Available Qty : ${cartdata.availablequantityinStock}",
                    fontsize: 14,
                    color: cGrey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: cGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: GooglePoppinsWidgets(text: '-', fontsize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 30,
                          width: 70,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: cGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: GooglePoppinsWidgets(text: '+', fontsize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: GooglePoppinsWidgets(
                    text: '${cartdata.totalAmount.toString()} /-',
                    fontsize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
