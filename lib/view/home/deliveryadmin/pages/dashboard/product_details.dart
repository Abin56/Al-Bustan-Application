import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/deliveryadmin.dart';
import 'package:flutter/material.dart';

class DeliveryAdminProductDetailsContainer extends StatelessWidget {
  const DeliveryAdminProductDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: cGrey.withOpacity(0.2)),
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding:const EdgeInsets.only(left: 12, top: 4, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GoogleFirasansWidgets( text: "PRODUCT DETAILS",
                              fontsize: 16,
                              fontWeight: FontWeight.w700,),
                          ),
                          const Icon(Icons.more_vert)
                        ],
                      ),
                    ),
                    DeliveryOverviewConatinerWidget(
                      height: 42,
                      width: 305,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                             padding: const EdgeInsets.all(8.0),
                            child: GoogleFirasansWidgets( text: "Inventory Summary",fontsize: 14, ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GoogleFirasansWidgets( text: "2",fontsize: 14, fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10),
                       child: DeliveryOverviewConatinerWidget(
                        height: 42,
                        width: 305,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GoogleFirasansWidgets( text: "Item Group",  fontsize: 14,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GoogleFirasansWidgets( text: "2", fontsize: 14,fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                      ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 10),
                       child: DeliveryOverviewConatinerWidget(
                        height: 42,
                        width: 305,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GoogleFirasansWidgets( text: "No. Of Items",  fontsize: 14,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GoogleFirasansWidgets( text: "12", fontsize: 14,fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),
                         ),
                     ),
                  ],
                ),
              );
  }
}