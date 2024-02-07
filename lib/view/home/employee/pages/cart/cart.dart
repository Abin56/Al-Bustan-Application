import 'package:canteen_productadd_application/controller/cart_controller/cart_controller.dart';
import 'package:canteen_productadd_application/controller/delivery_controller/delivery_controller.dart';
import 'package:canteen_productadd_application/model/canteen_model/canteen_model.dart';
import 'package:canteen_productadd_application/model/cart_model/cart_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/custom_showDilog/custom_showdilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartWidget extends StatelessWidget {
  CartWidget({super.key});

  final cartCtr = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    cartCtr.canteenID.value = "";
    cartCtr.canteenName.value = "";

    return Scaffold(
      appBar: AppBar(
        title: GooglePoppinsWidgets(text: "Cart", fontsize: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GooglePoppinsWidgets(text: "Select Canteen", fontsize: 16),
            sh10,
            CanteenSetUpWidget(),
            sh20,
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('AllUsersCollection')
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
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.shade200,
                            //     offset: const Offset(2.0, 2.0),
                            //     blurRadius: 6.0,
                            //     spreadRadius: 2.0,
                            //   ),
                            //   BoxShadow(
                            //     color: Colors.grey.shade200,
                            //     offset: const Offset(-1.0, -1.0),
                            //     blurRadius: 8.0,
                            //     spreadRadius: 2.0,
                            //   ),
                            // ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 95,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'images/Al_bustan.jpg'),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    sw10,
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   cartData.productname,
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       fontWeight: FontWeight.w500,
                                          //       overflow:
                                          //           TextOverflow.ellipsis),
                                          // ),
                                          GooglePoppinsWidgets(
                                            text: cartData.productname,
                                            fontsize: 14,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          GooglePoppinsWidgets(
                                            text:
                                                "Available Qty : ${cartData.availablequantityinStock}",
                                            fontsize: 14,
                                            color: cGrey,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartCtr
                                                      .lessQuantity(cartData);
                                                },
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: cLateGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: GooglePoppinsWidgets(
                                                        text: '-',
                                                        fontsize: 16),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 70,
                                                  child: TextField(
                                                    controller:
                                                        controllers[index],
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 0,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                    color: cLateGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: GooglePoppinsWidgets(
                                                        text: '+',
                                                        fontsize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '₹ ${cartData.totalAmount.toString()}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          // GooglePoppinsWidgets(
                                          //   text:
                                          //       '₹ ${cartData.totalAmount.toString()}',
                                          //   fontsize: 15,
                                          //   fontWeight: FontWeight.w600,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: Center(
                                    //     child: GooglePoppinsWidgets(
                                    //         text:
                                    //             cartData.totalAmount.toString(),
                                    //         fontsize: 15),
                                    //   ),
                                    // )
                                  ],
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    showDialogWidget(
                                        context: context,
                                        title:
                                            "Are you Sure to Remove item from cart",
                                        function: () {
                                          cartCtr.removeItemFromCart(
                                              cartData.docId);
                                        });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: cLateGrey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: cGrey,
                                            size: 18,
                                          ),
                                          sw5,
                                          GooglePoppinsWidgets(
                                            text: "Remove",
                                            fontsize: 14,
                                            color: cGrey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
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
            if (cartCtr.canteenID.value != "") {
              cartCtr.addEmployeeRequest();
            } else {
              showToast(msg: "Please Select Canteen");
            }

            // cartCtr.cartToRequestDeliveryOrder();
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

// class CartTile extends StatelessWidget {
//   const CartTile({
//     super.key,
//     required this.cartdata,
//   });
//   final CartModel cartdata;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: cWhite,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: cGrey,
//           width: 1.0,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             offset: const Offset(2.0, 2.0),
//             blurRadius: 6.0,
//             spreadRadius: 2.0,
//           ),
//           BoxShadow(
//             color: Colors.grey.shade200,
//             offset: const Offset(-1.0, -1.0),
//             blurRadius: 8.0,
//             spreadRadius: 2.0,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 height: 80,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     image: const DecorationImage(
//                         image: AssetImage('images/Al_bustan.jpg'),
//                         fit: BoxFit.cover)),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GooglePoppinsWidgets(
//                       text: cartdata.productname, fontsize: 14),
//                   GooglePoppinsWidgets(
//                     text:
//                         "Available Qty : ${cartdata.availablequantityinStock}",
//                     fontsize: 14,
//                     color: cGrey,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           color: cGrey,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: GooglePoppinsWidgets(text: '-', fontsize: 16),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: SizedBox(
//                           height: 30,
//                           width: 70,
//                           child: TextField(
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10))),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           color: cGrey,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: GooglePoppinsWidgets(text: '+', fontsize: 16),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Center(
//                 child: GooglePoppinsWidgets(
//                     text: '${cartdata.totalAmount.toString()} /-',
//                     fontsize: 15),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class CanteenSetUpWidget extends StatelessWidget {
  CanteenSetUpWidget({
    Key? key,
  }) : super(key: key);

  final cartCtr = Get.put(CartController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.blue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: cGrey.withOpacity(0.2))),
      child: Center(
        child: Form(
          key: _formKey,
          child: DropdownSearch<CanteenModel>(
            validator: (item) {
              if (item == null) {
                return "Required field";
              } else {
                return null;
              }
            },
            asyncItems: (value) {
              cartCtr.canteenList.clear();
              return cartCtr.fetchcanteenModel();
            },
            itemAsString: (value) => value.schoolName,
            onChanged: (value) async {
              if (value != null) {
                cartCtr.canteenName.value = value.schoolName;
                cartCtr.canteenID.value = value.docId;
              }
            },
            onSaved: (value) {
              // Do something with the selected value when the form is saved.
              // You can update the data or perform any necessary actions.
              print("Form saved: $value");
            },
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            popupProps: const PopupProps.menu(
                searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        hintText: "Search Canteen",
                        border: OutlineInputBorder())),
                showSearchBox: true,
                searchDelay: Duration(microseconds: 10)),
          ),
        ),
      ),
    );
  }
}
