import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/deliveryadmin.dart';
import 'package:flutter/material.dart';

class DeliveyAdminStockOverviewContainer extends StatelessWidget {
  const DeliveyAdminStockOverviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: cGrey.withOpacity(0.2)),
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 4, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GoogleFirasansWidgets(
                              text: "STOCK OVERVIEW",
                             fontsize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Icon(Icons.more_vert)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                           Padding(
                              padding: const EdgeInsets.only(left: 5,),
                              child: DeliveryOverviewConatinerWidget(
                                height: 55,
                                width: 150,
                                child: Row(
                                  children: [
                                    Image.asset("images/total_stock.png", width: 30, height: 30,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GoogleFirasansWidgets(text: "Total Stock", fontsize: 13),
                                          GoogleFirasansWidgets( text: '10', fontsize: 13,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    )
                                  ],
                                ), 
                              )
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 0),
                            child: DeliveryOverviewConatinerWidget(
                              height: 55,
                              width: 150,
                              child: Row(
                                children: [
                                  Image.asset("images/pending_order.png", width: 33,height: 33,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GoogleFirasansWidgets(text: "Pending Order", fontsize: 13),
                                        GoogleFirasansWidgets( text:"10", fontsize: 13,fontWeight: FontWeight.bold,),
                                      ],
                                    ),
                                  )
                                ],
                              ), // text: ,text1: ,imageasset: 
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row( 
                        children: [
                           Padding(
                              padding: const EdgeInsets.only(left: 8,),
                              child: DeliveryOverviewConatinerWidget(
                                height: 55,
                                width: 150,
                                child: Row(
                                  children: [
                                    Image.asset( "images/order.png", width: 35,height: 35, ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GoogleFirasansWidgets(text: "Delivered", fontsize: 13),
                                          GoogleFirasansWidgets( text: '10', fontsize: 13,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10, ),
                              child: DeliveryOverviewConatinerWidget(
                                height: 55,
                                width: 150,
                                child: Row(
                                  children: [
                                    Image.asset("images/profile.png",width: 30,height: 30, ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GoogleFirasansWidgets(text: "Request", fontsize: 13),
                                          GoogleFirasansWidgets(text: "10", fontsize: 13,fontWeight: FontWeight.bold,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }
}