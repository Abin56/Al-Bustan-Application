import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/constant/const.dart';
import 'package:canteen_productadd_application/view/constant/constant.validate.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryAdminPickedOrderPage extends StatelessWidget {
  const DeliveryAdminPickedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: themeColorBlue,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: cWhite,)),
          title: GoogleLoraWidgets(text: "Picked Orders",fontsize: 19,color: cWhite,fontWeight: FontWeight.bold,),
      ),
      body : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 900,
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
                 //  HeaderOfDeliveryAdmin(text:  "Print",flex: 2) 
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("collectionPath")
                  .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.docs[index];
                        return   SizedBox(
                          width: 900,
                          height: 45,
                          child: Row(
                            children: [ 
                            DeliveryAdminListContainers(text:  '${index+1}',flex: 1),
                            DeliveryAdminListContainers(text:  data['orderId'],flex: 3,),
                            DeliveryAdminListContainers(text:  data['orderCount'].toString() ,flex: 2,),
                            DeliveryAdminListContainers(text:  dateConveter(DateTime.parse(data['time'])),flex: 2,),
                            DeliveryAdminListContainers(text:  data['assignStatus'],flex: 2,),
                            DeliveryAdminListContainers(text:  timeConveter(DateTime.parse(data['time'])),flex: 2,),
                            DeliveryAdminListContainers(text:  data['price'],flex: 2,),
                           //  const DeliveryAdminListContainers(text:  "Action",flex: 2,),
                            ],
                          ),
                        );
                      },
                       separatorBuilder: (context, index) => const SizedBox(height: 1,), 
                       itemCount: snapshot.data!.docs.length);
                  }else{
                  return  GoogleLoraWidgets(text: "NO Data", fontsize: 14);
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