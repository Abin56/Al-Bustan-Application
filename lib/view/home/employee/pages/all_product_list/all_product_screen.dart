import 'package:canteen_productadd_application/controller/cart_controller/cart_controller.dart';
import 'package:canteen_productadd_application/model/all_product_model/all_productModel.dart';
import 'package:canteen_productadd_application/model/produt_adding_model/product_adding_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/cart/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GooglePoppinsWidgets(text: "All Product List", fontsize: 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SingleHeadWidget(headName: "Image"),
                  SingleHeadWidget(headName: "Name"),
                  SingleHeadWidget(headName: "Qty"),
                  SingleHeadWidget(headName: "In Proice"),
                  SingleHeadWidget(headName: "Out Price"),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('AvailableProducts')
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
                          final productData = ProductAddingModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return ProductTile(
                            productData: productData,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return sh10;
                        },
                        itemCount: snapshot.data!.docs.length);
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CartWidget(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 10,
            color: cGreen,
            child: Center(
                child: GooglePoppinsWidgets(
              text: "Go To Cart",
              fontsize: 16,
              color: cWhite,
            )),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: GooglePoppinsWidgets(text: 'Go to Cart', fontsize: 14),
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => CartWidget(),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class SingleHeadWidget extends StatelessWidget {
  const SingleHeadWidget({super.key, required this.headName});
  final String headName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: GooglePoppinsWidgets(
        text: headName,
        fontsize: 14,
        fontWeight: FontWeight.bold,
      ),
    ));
  }
}

class ProductTile extends StatelessWidget {
  ProductTile({super.key, required this.productData});
  final ProductAddingModel productData;
  final cartCtr = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
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
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('images/Al_bustan.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: GooglePoppinsWidgets(
                    text: productData.productname, fontsize: 14),
              ),
            ),
            Expanded(
              child: Center(
                child: GooglePoppinsWidgets(
                    text: productData.quantityinStock.toString(), fontsize: 14),
              ),
            ),
            Expanded(
              child: Center(
                child: GooglePoppinsWidgets(
                    text: productData.outPrice.toString(), fontsize: 14),
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                  onPressed: () {
                    cartCtr.addToEmployeeCart(data: productData);
                  },
                  icon: const Icon(Icons.shopping_cart_rounded),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
