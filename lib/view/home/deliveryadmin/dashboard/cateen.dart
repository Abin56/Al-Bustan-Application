import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/deliveryadmin.dart';
import 'package:flutter/material.dart';

class DeliveryAdminCateenContainer extends StatelessWidget {
  const DeliveryAdminCateenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: cGrey.withOpacity(0.2)),
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, right: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoogleFirasansWidgets(
                            text: "CANTEENS",
                            fontsize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          const Row(
                            children: [
                               Icon(Icons.add),
                               SizedBox(width: 20,),
                              Icon(Icons.more_vert),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DeliveryOverviewConatinerWidget(
                        height: 130,
                        width: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "images/restaurant.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GoogleFirasansWidgets(
                                      text: "No. of Canteen", fontsize: 15),
                                  GoogleFirasansWidgets(
                                      text: "02", fontsize: 15,fontWeight: FontWeight.bold,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}