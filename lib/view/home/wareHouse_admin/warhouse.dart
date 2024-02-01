import 'package:canteen_productadd_application/controller/add_product_controller/add_product_controller.dart';
import 'package:canteen_productadd_application/controller/barcode_controller/barcode_controller.dart';
import 'package:canteen_productadd_application/controller/search_product_controller/search_product_controller.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/fonts/google_monstre.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/wareHouse_admin/pages/search_product/search_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_scroll/text_scroll.dart';

class WareHouseHomePage extends StatelessWidget {
  final SearchProductController searchProductController =
      Get.put(SearchProductController());
  final AddProductController addProductController =
      Get.put(AddProductController());
  final BarcodeController barcodeController = Get.put(BarcodeController());
  WareHouseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(children: [
    //       const Padding(
    //         padding: EdgeInsets.only(top: 8, left: 10),
    //         child: Row(
    //           children: [
    //             Text(
    //               "Purchase Overview",
    //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           height: 300,
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: const Color.fromARGB(255, 208, 230, 246),
    //             border: Border.all(color: Colors.white),
    //             boxShadow: const [
    //               BoxShadow(
    //                   color: Color.fromARGB(255, 20, 145, 248),
    //                   offset: Offset(2, 2),
    //                   blurRadius: 4,
    //                   blurStyle: BlurStyle.outer)
    //             ],
    //             borderRadius: BorderRadius.circular(20),
    //             // color: const Color.fromARGB(255, 193, 193, 193)
    //           ),
    //           child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     const Spacer(),
    //                     Container(
    //                       height: 140,
    //                       width: 150,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(color: Colors.white),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         // color: const Color.fromARGB(255, 255, 225, 238)
    //                       ),
    //                       child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.shopify_rounded),
    //                             Text(
    //                               "Total Purchase",
    //                               style: TextStyle(fontWeight: FontWeight.w500),
    //                             ),
    //                             Text("712")
    //                           ]),
    //                     ),
    //                     const Spacer(),
    //                     const Padding(
    //                       padding: EdgeInsets.only(bottom: 150),
    //                       child: Icon(Icons.more_vert_outlined,
    //                           color: Colors.white),
    //                     )
    //                   ],
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         //color: const Color.fromARGB(255, 201, 228, 247)
    //                       ),
    //                       child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Container(
    //                               height: 25,
    //                               width: 25,
    //                               decoration: const BoxDecoration(
    //                                   image: DecorationImage(
    //                                       image: AssetImage(
    //                                           "images/cart_cancel.png"))),
    //                             ),
    //                             //Icon(Icons.food_bank),
    //                             const Padding(
    //                               padding: EdgeInsets.only(left: 15),
    //                               child: Text("Cancelled Order"),
    //                             ),
    //                             const Text("132")
    //                           ]),
    //                     ),
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         // color: const Color.fromARGB(255, 201, 228, 247)
    //                       ),
    //                       child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.rotate_90_degrees_ccw),
    //                             Text("Returns"),
    //                             Text("132")
    //                           ]),
    //                     ),
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         //  color: const Color.fromARGB(255, 201, 228, 247)
    //                       ),
    //                       child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.auto_graph),
    //                             Text("Cost"),
    //                             Text("132")
    //                           ]),
    //                     ),
    //                   ],
    //                 )
    //               ]),
    //         ),
    //       ),
    //       const Row(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.only(left: 10),
    //             child: Text(
    //               "Stock Overview",
    //               style: TextStyle(fontSize: 20),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           height: 300,
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             color: const Color.fromARGB(255, 208, 230, 246),
    //             border: Border.all(
    //               color: Colors.white,
    //             ),
    //             boxShadow: const [
    //               BoxShadow(
    //                   color: Colors.blue,
    //                   offset: Offset(2, 2),
    //                   blurRadius: 4,
    //                   blurStyle: BlurStyle.outer)
    //             ],
    //             borderRadius: BorderRadius.circular(20),

    //             /// color: const Color.fromARGB(255, 254, 223, 232)
    //           ),
    //           child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 Row(
    //                   children: [
    //                     const Spacer(),
    //                     Container(
    //                       height: 140,
    //                       width: 150,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         // color: Colors.amber[50]
    //                       ),
    //                       child:  Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Container(
    //                               height: 25,
    //                               width: 25,
    //                               decoration: const BoxDecoration(
    //                                   image: DecorationImage(
    //                                       image: AssetImage(
    //                                           "images/warehouse-alt.png"))),
    //                             ),
    //                             const Text("Total Stocks",
    //                                 style:
    //                                     TextStyle(fontWeight: FontWeight.w500)),
    //                             const Text("712")
    //                           ]),
    //                     ),
    //                     const Spacer(),
    //                     const Padding(
    //                       padding: EdgeInsets.only(bottom: 150),
    //                       child: Icon(Icons.more_vert_outlined,
    //                           color: Colors.white),
    //                     ),
    //                   ],
    //                 ),

    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         //  color: const Color.fromARGB(255, 201, 228, 247)
    //                       ),
    //                       child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.pending),
    //                             Padding(
    //                               padding: EdgeInsets.only(left: 20),
    //                               child: Text("Purchase Pending"),
    //                             ),
    //                             Text("132")
    //                           ]),
    //                     ),
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         // color: const Color.fromARGB(255, 201, 228, 247)
    //                       ),
    //                       child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.receipt_long),
    //                             Padding(
    //                               padding: EdgeInsets.only(left: 18),
    //                               child: Text("Will be Received"),
    //                             ),
    //                             Text("132")
    //                           ]),
    //                     ),
    //                     Container(
    //                       height: 100,
    //                       width: 100,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         border: Border.all(
    //                           color: Colors.white,
    //                         ),
    //                         boxShadow: const [
    //                           BoxShadow(
    //                               color: Colors.blue,
    //                               offset: Offset(2, 2),
    //                               blurRadius: 4,
    //                               blurStyle: BlurStyle.outer)
    //                         ],
    //                         borderRadius: BorderRadius.circular(20),
    //                         // color: const Color.fromARGB(255, 201, 228, 247)
    //                       ),
    //                       child: const Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Icon(Icons.notifications_active),
    //                             Text("Request Alert"),
    //                             Text("132")
    //                           ]),
    //                     ),
    //                   ],
    //                 ),
    //                 // const Padding(
    //                 //   padding: EdgeInsets.only(bottom: 250),
    //                 //   child: Icon(Icons.more_vert_outlined),
    //                 // ),
    //               ]),
    //         ),
    //       ),
    //       const Row(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.only(left: 10),
    //             child: Text(
    //               "Orders",
    //               style: TextStyle(fontSize: 20),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 8,bottom: 15,left: 8,right: 8),
    //         child: Container(
    //           height: 180,
    //           width: double.infinity,
    //           decoration: BoxDecoration(
    //             border: Border.all(
    //               color: const Color.fromARGB(255, 146, 203, 250),
    //             ),
    //             boxShadow: const [
    //               BoxShadow(
    //                   color: Colors.blue,
    //                   offset: Offset(2, 2),
    //                   blurRadius: 4,
    //                   blurStyle: BlurStyle.outer)
    //             ],
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.only(left: 8,
    //               top: 25,
    //             ),
    //             child: Row(
    //               children: [
    //                 Container(
    //                   height: 150,
    //                   width: 150,
    //                   decoration: const BoxDecoration(
    //                       image: DecorationImage(
    //                           image: NetworkImage(
    //                               "https://st.depositphotos.com/1734074/5127/v/450/depositphotos_51276039-stock-illustration-vector-food-delivery-car-icon.jpg"))),
    //                 ),
    //                 const Spacer(),
    //                 const Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         " Total Order: 90",
    //                         style: TextStyle(fontSize: 18),
    //                       ),
    //                       Padding(
    //                         padding: EdgeInsets.only(left: 8.0),
    //                         child: Text(
    //                           "To Be Deliver: 10",
    //                           style: TextStyle(fontSize: 18),
    //                         ),
    //                       ),
    //                     ]),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       SingleChildScrollView(
    //         scrollDirection: Axis.horizontal,
    //         child: Row(
    //           children: [
    //             Container(
    //               height: 200,
    //               width: 180,
    //               decoration: BoxDecoration(
    //                 boxShadow: const [
    //                   BoxShadow(
    //                       color: Colors.blue,
    //                       offset: Offset(2, 2),
    //                       blurRadius: 4,
    //                       blurStyle: BlurStyle.outer)
    //                 ],
    //                 border: Border.all(
    //                   color: const Color.fromARGB(255, 146, 203, 250),
    //                 ),
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               child: const Row(children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Padding(
    //                       padding: EdgeInsets.only(bottom: 15, top: 8, left: 8),
    //                       child: Text(
    //                         "Product Details",
    //                         style: TextStyle(fontSize: 18),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(left: 8),
    //                       child: Row(
    //                         children: [
    //                           Icon(Icons.star, size: 10),
    //                           Text(" Inventory summery: 02"),
    //                         ],
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(left: 8),
    //                       child: Row(
    //                         children: [
    //                           Icon(Icons.star, size: 10),
    //                           Text(" Item Group: 14"),
    //                         ],
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(left: 8),
    //                       child: Row(
    //                         children: [
    //                           Icon(Icons.star, size: 10),
    //                           Text(" No of Iteam: 104"),
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 )
    //               ]),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(left: 5),
    //               child: Container(
    //                 height: 200,
    //                 width: 180,
    //                 decoration: BoxDecoration(
    //                   boxShadow: const [
    //                     BoxShadow(
    //                         color: Colors.blue,
    //                         offset: Offset(2, 2),
    //                         blurRadius: 4,
    //                         blurStyle: BlurStyle.outer)
    //                   ],
    //                   border: Border.all(
    //                     color: const Color.fromARGB(255, 146, 203, 250),
    //                   ),
    //                   borderRadius: BorderRadius.circular(20),
    //                 ),
    //                 child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       const Padding(
    //                         padding: EdgeInsets.only(left: 10, top: 10),
    //                         child: Text(
    //                           "Canteen",
    //                           style: TextStyle(fontSize: 18),
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 20, top: 20),
    //                         child: Container(
    //                           height: 100,
    //                           width: 100,
    //                           decoration: const BoxDecoration(
    //                               image: DecorationImage(
    //                                   image: NetworkImage(
    //                                       "https://media.istockphoto.com/id/164309417/vector/school-canteen.jpg?s=612x612&w=0&k=20&c=ZW9463dZDruUoU-8xRwa5e6VQjf9aKxxPT7Vk5GacGM="))),
    //                         ),
    //                       ),
    //                       const Padding(
    //                         padding: EdgeInsets.only(left: 10),
    //                         child: Text("No of Canteen :89"),
    //                       )
    //                     ]),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(15.0),
    //         child: Container(
    //           height: 180,
    //           width: double.infinity,
    //           decoration: const BoxDecoration(
    //               boxShadow: [BoxShadow(color: Colors.grey)],
    //               image: DecorationImage(
    //                   fit: BoxFit.cover,
    //                   image: NetworkImage(
    //                       "https://www.shutterstock.com/image-vector/abstract-financial-chart-arrow-260nw-1028158363.jpg"))),
    //         ),
    //       ),
    //     ]),
    //   ),
    // );
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('AllUsersCollection')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snap) {
              if (snap.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(snap.data!.data()!['imageURl']),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Name :", fontsize: 16),
                                    SizedBox(
                                      child: TextScroll(
                                        ' ${snap.data!.data()!['name']}',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Email :", fontsize: 12),
                                    SizedBox(
                                      child: TextScroll(
                                        ' ${snap.data!.data()!['email']}',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Phone No :", fontsize: 12),
                                    SizedBox(
                                      child: TextScroll(
                                        ' ${snap.data!.data()!['phoneNo']}',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Row(
                                  children: [
                                    GooglePoppinsWidgets(
                                        text: "  Status :", fontsize: 12),
                                    SizedBox(
                                      child: TextScroll(
                                        snap.data!.data()!['activate'] == true
                                            ? '  Active'
                                            : 'Not Active',
                                        style: const TextStyle(
                                          color: cBlack,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: GestureDetector(
                                onTap: () async {
                                  showSearch(
                                      context: context,
                                      delegate: AllTempProductSearch(
                                          navvalue: 'manual'));
                                },
                                child: Container(
                                  //  width: 200,
                                  height: 40,
                                  color: const Color.fromARGB(255, 2, 179, 89),
                                  child: Center(
                                      child: GoogleMonstserratWidgets(
                                    text: "Add Product Manually",
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 7,
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  showSearch(
                                      context: context,
                                      delegate: AllTempProductSearch(
                                          navvalue: 'add'));
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     Future.delayed(const Duration(seconds: 1));
                                  //     Get.back();

                                  //     return BarcodeScanner(
                                  //         lineColor: '#ff6666',
                                  //         cancelButtonText: "Cancel",
                                  //         isShowFlashIcon: false,
                                  //         scanType: ScanType.barcode,
                                  //         appBarTitle: '',
                                  //         centerTitle: true,
                                  //         onScanned: (res) async {
                                  //           barcodeController.barcodevalue.value = res;
                                  //           await barcodeController
                                  //               .barcodescanResult(res)
                                  //               .then((value) {
                                  //             if (Get.find<BarcodeController>()
                                  //                         .barcodevalue
                                  //                         .value ==
                                  //                     '' ||
                                  //                 Get.find<BarcodeController>()
                                  //                         .barcodevalue
                                  //                         .value ==
                                  //                     '-1') {
                                  //               return Get.back();
                                  //             } else {
                                  //               Get.to(() => AddProductManual(
                                  //                     barcoodevalue:
                                  //                         Get.find<BarcodeController>()
                                  //                             .barcodevalue
                                  //                             .value,
                                  //                   ));
                                  //             }
                                  //           });
                                  //         });
                                  //   },
                                  // ));
                                },
                                child: Container(
                                  //  width: 200,
                                  height: 40,
                                  color:
                                      const Color.fromARGB(255, 25, 165, 152),
                                  child: Center(
                                      child: GoogleMonstserratWidgets(
                                    text: "Add New Product",
                                    fontsize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: circularPIndicator,
                );
              }
            }));
  }
}
