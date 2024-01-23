import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/dashboard/cateen.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/dashboard/delivery_overview.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/dashboard/product_details.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/dashboard/stock_overview.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/dashboard/yearly_analysis.dart';
import 'package:flutter/material.dart';

class DeliveryAdminHomePage extends StatelessWidget {
  const DeliveryAdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DeliveryAdminOverviewContainer(),
            ), /////////////////////////////////////////////
             Padding(
              padding: EdgeInsets.all(8.0),
              child: DeliveyAdminStockOverviewContainer()
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DeliveryAdminProductDetailsContainer()
            ), //////////////////////////////////////
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DeliveryAdminCateenContainer()
            ), /////////////////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DeliveryAdminYearlyAnalysisConatiner()
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryOverviewConatinerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const DeliveryOverviewConatinerWidget({
    required this.width,
    required this.height,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromARGB(255, 98, 106, 104),
            offset: Offset.zero,
            blurRadius: 2.0,
            spreadRadius: 0.0)
      ], borderRadius: BorderRadius.all(Radius.circular(10)), color: cWhite),
      width: width,
      height: height,
      child: Padding(padding: const EdgeInsets.all(4.0), child: child
          //  Row(
          //  children: [
          //    Image.asset(imageasset!,width: 40,height: 40,),
          //    Column(
          //      children: [
          //        GoogleFirasansWidgets(text: text, fontsize: 13),
          //        GoogleFirasansWidgets(text: text1, fontsize: 13),
          //      ],
          //    )
          //  ],
          // ),
          ),
    );
  }
}
