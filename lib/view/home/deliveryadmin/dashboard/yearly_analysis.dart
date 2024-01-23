import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/deliveryadmin.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/dashboard/graph/delivery_graph.dart';
import 'package:flutter/material.dart';

class DeliveryAdminYearlyAnalysisConatiner extends StatelessWidget {
  const DeliveryAdminYearlyAnalysisConatiner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                      border: Border.all(width: 1, color: cGrey.withOpacity(0.2)),
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                child:  Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GoogleFirasansWidgets( text: "YEARLY ANALYSIS", fontsize: 16,fontWeight: FontWeight.w700,),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: DeliveryOverviewConatinerWidget(
                          height: 160,
                          width: 350,
                          child: DeliveryStatusGraph()),
                      ),
                    ],
                  ),
                ),
              );
  }
}