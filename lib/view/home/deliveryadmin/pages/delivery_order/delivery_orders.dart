import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryAdminDeliveryOrderPage extends StatelessWidget {
  const DeliveryAdminDeliveryOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: themeColorBlue,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back)),
          title: GoogleLoraWidgets(text: "Delivered Orders",fontsize: 19,color: cWhite,fontWeight: FontWeight.bold,),
      ),
      body:   SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 910,
          height: 700,
          child: Column(
            children: [
              const Row(
                children: [ 
                  HeaderOfDeliveryAdmin(text: "No.",flex: 1),
                   HeaderOfDeliveryAdmin(text: "Order ID",flex: 3),
                    HeaderOfDeliveryAdmin(text: "Order Quantity",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Order Date",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Order Status",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Order Time",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Price",flex: 2),
                   HeaderOfDeliveryAdmin(text:  "Print",flex: 2)
                  
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("DeliveredList")
                  .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return   SizedBox(
                          width: 910,
                          height: 45,
                          child: Row(
                                          children: [ 
                           DeliveryAdminListContainers(text:  '${index+1}',flex: 1),
                           DeliveryAdminListContainers(text:  data['orderId'].toString(),flex: 3,),
                           DeliveryAdminListContainers(text:  data['orderCount'].toString(),flex: 2,),
                           DeliveryAdminListContainers(text:  dateConveter(DateTime.parse(data['time'])),flex: 2,),
                           DeliveryAdminListContainers(text:  data['statusMessage'],flex: 2,),
                           DeliveryAdminListContainers(text:  timeConveter(DateTime.parse(data['time'])),flex: 2,),
                           DeliveryAdminListContainers(text:  data['price'].toString(),flex: 2,),
                           const DeliveryAdminListContainers(text:  "Action",flex: 2,),
                          
                                          ],
                                        ),
                        );
                      },
                       separatorBuilder: (context, index) => const SizedBox(height: 1,), 
                       itemCount: snapshot.data!.docs.length);
                  }else{
                    return GoogleFirasansWidgets(text: "No Data", fontsize: 13);
                  }
                  }
                ),
              ),
              
            ],
          )),
      ),
    );
  }
}