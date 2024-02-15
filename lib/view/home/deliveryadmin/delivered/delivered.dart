import 'package:canteen_productadd_application/controller/delivery_controller/delivery_controller.dart';
import 'package:canteen_productadd_application/model/delivery/delivery_model/delivery_model.dart';
import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/button_container_widget/button_container_widget.dart';
import 'package:canteen_productadd_application/view/widgets/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DeliveredList extends StatelessWidget {
  DeliveredList({super.key});

  // final employeeController = Get.put(EmployeeController());
  final getDeliveryCtr = Get.put(DeliveryController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              height: size.height,
              width: 1200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GooglePoppinsWidgets(
                      text: 'Delivered List',
                      fontsize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    sh10,
                    //  <<<<<<< list(table) >>>>>>>>>
                    Container(
                      decoration: BoxDecoration(
                        // color: AppColors.greenColor,
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                            0.1,
                            0.4,
                            0.6,
                            0.9,
                          ],
                          colors: [
                            Color(0xFF35B2A2),
                            Color(0xFF11967F),
                            Color(0xFF06876A),
                            Color(0xFF036952),
                          ],
                        ),
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Order ID",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Order Quantity",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Order Date",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Order Status",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  " Order Time",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Price",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "",
                                  style: AppTextStyles.textStyle1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('DeliveredList')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: GooglePoppinsWidgets(
                                    text: "No data", fontsize: 15),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: GooglePoppinsWidgets(
                                    text: "No data", fontsize: 15),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data = DeliveryModel.fromMap(
                                      snapshot.data!.docs[index].data());
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  data.orderid,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .deliveryTextStyle1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  data.orderCount.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .deliveryTextStyle1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  dateConveter(
                                                    DateTime.parse(data.time),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .deliveryTextStyle1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  child: Center(
                                                    child: Text(
                                                      data.statusMessage,
                                                      style: const TextStyle(
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Center(
                                              //   child: Container(
                                              //     decoration: BoxDecoration(
                                              //       color: data['isDelivered'] == true
                                              //           ? Colors.green
                                              //           : (data['assignStatus'] ==
                                              //                   false
                                              //               ? Colors.amber
                                              //               : AppColors.indigoColor),
                                              //       borderRadius:
                                              //           BorderRadius.circular(5),
                                              //       border: Border.all(
                                              //         width: 1,
                                              //       ),
                                              //     ),
                                              //     child: Padding(
                                              //       padding: const EdgeInsets.all(2),
                                              //       child: data['isDelivered'] == true
                                              //           ? const Text(
                                              //               "Delivered",
                                              //               style: TextStyle(
                                              //                 color: AppColors
                                              //                     .whiteColor,
                                              //               ),
                                              //             )
                                              //           : data['assignStatus'] ==
                                              //                   false
                                              //               ? SizedBox(
                                              //                   height: 40,
                                              //                   child: DropdownSearch<
                                              //                       EmployeeProfileCreateModel>(
                                              //                     autoValidateMode:
                                              //                         AutovalidateMode
                                              //                             .always,
                                              //                     asyncItems:
                                              //                         (value) {
                                              //                       employeeController
                                              //                           .employeeList
                                              //                           .clear();
                                              //                       return employeeController
                                              //                           .fetchEmployees();
                                              //                     },
                                              //                     itemAsString:
                                              //                         (value) =>
                                              //                             value.name,
                                              //                     onChanged:
                                              //                         (value) async {
                                              //                       if (value !=
                                              //                           null) {
                                              //                         employeeController
                                              //                                 .employeeUID
                                              //                                 .value =
                                              //                             value.docid;
                                              //                         employeeController
                                              //                                 .employeeName =
                                              //                             value.name;
                                              //                       }
                                              //                       final employeeID =
                                              //                           Get.find<
                                              //                                   EmployeeController>()
                                              //                               .employeeUID;
                                              //                       final emplopeeName =
                                              //                           Get.find<
                                              //                                   EmployeeController>()
                                              //                               .employeeName;
                                              //                       getDeliveryCtr
                                              //                           .createDeliveryAssignToEmployee(
                                              //                         employeeName:
                                              //                             emplopeeName,
                                              //                         employeeId:
                                              //                             employeeID
                                              //                                 .value,
                                              //                         deliverydata:
                                              //                             data,
                                              //                       );
                                              //                     },
                                              //                     dropdownDecoratorProps:
                                              //                         DropDownDecoratorProps(
                                              //                       baseStyle:
                                              //                           GoogleFonts
                                              //                               .poppins(
                                              //                         // fontSize: 13,
                                              //                         color: Colors
                                              //                             .black
                                              //                             .withOpacity(
                                              //                                 0.5),
                                              //                       ),
                                              //                     ),
                                              //                   ),
                                              //                 )
                                              //               : StreamBuilder(
                                              //                   stream: FirebaseFirestore
                                              //                       .instance
                                              //                       .collection(
                                              //                           'EmployeeProfile')
                                              //                       .doc(data[
                                              //                           'employeeId'])
                                              //                       .collection(
                                              //                           'DeliveryRequest')
                                              //                       .doc(data[
                                              //                           'orderId'])
                                              //                       .collection(
                                              //                           'productsDetails')
                                              //                       .snapshots(),
                                              //                   builder: (context,
                                              //                       statussnap) {
                                              //                     if (snapshot
                                              //                         .hasData) {
                                              //                       if (statussnap
                                              //                               .connectionState ==
                                              //                           ConnectionState
                                              //                               .waiting) {
                                              //                         return const SizedBox();
                                              //                       } else if (statussnap
                                              //                           .data!
                                              //                           .docs
                                              //                           .isEmpty) {
                                              //                         return const Text(
                                              //                           "Picked up",
                                              //                           style:
                                              //                               TextStyle(
                                              //                             color: AppColors
                                              //                                 .whiteColor,
                                              //                           ),
                                              //                         );
                                              //                       } else {
                                              //                         return const Padding(
                                              //                           padding: EdgeInsets
                                              //                               .symmetric(
                                              //                                   horizontal:
                                              //                                       6),
                                              //                           child: Text(
                                              //                             'Pending',
                                              //                             style:
                                              //                                 TextStyle(
                                              //                               color: AppColors
                                              //                                   .whiteColor,
                                              //                               // fontSize:
                                              //                               //     18,
                                              //                             ),
                                              //                           ),
                                              //                         );
                                              //                       }
                                              //                     } else {
                                              //                       return const Text(
                                              //                           '');
                                              //                     }
                                              //                   },
                                              //                 ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  timeConvert(data.time),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles
                                                      .deliveryTextStyle1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  data.price.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // style: AppTextStyles
                                                  //     .deliveryTextStyle1,
                                                ),
                                              ),
                                            ),
                                            // data['assignStatus'] == true
                                            //     ?
                                            Expanded(
                                              child: Center(
                                                  child: ButtonContainerWidget(
                                                text: 'Print',
                                                width: 100,
                                                height: size.height * 0.05,
                                                fontSize: 16,
                                                onTap: () {
                                                  // printReceipt();
                                                },
                                              )

                                                  // CustomGradientButton(
                                                  //   height: size.height * 0.05,
                                                  //   width: size.width * 0.06,
                                                  //   onPressed: () {
                                                  //
                                                  //   },
                                                  //   text: 'Print',
                                                  // ),
                                                  ),
                                            )
                                            // : const Expanded(child: SizedBox())
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey.shade200,
                                        height: 3,
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String timeConvert(String timestampString) {
  DateTime timestamp = DateTime.parse(timestampString);
  String formattedTime = DateFormat.jm().format(timestamp);
  return formattedTime;
}
