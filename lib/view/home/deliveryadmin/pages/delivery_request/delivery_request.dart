import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeliveryAdminDeliveryRequestPage extends StatelessWidget {
  const DeliveryAdminDeliveryRequestPage({super.key});

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
          title: GoogleLoraWidgets(text: "Delivery Request",fontsize: 19,color: cWhite,fontWeight: FontWeight.bold,),
      ),
      body:    SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 870,
          height: 700,
          child: Column(
            children: [
              const Row(
                children: [ 
                   HeaderOfDeliveryAdmin(text: "No.",flex: 1),
                   HeaderOfDeliveryAdmin(text: "Request ID",flex: 3),
                   HeaderOfDeliveryAdmin(text: "Employee Name",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Time",flex: 1),
                   HeaderOfDeliveryAdmin(text: "Quantity",flex: 1),
                   HeaderOfDeliveryAdmin(text: "Price",flex: 2),
                   HeaderOfDeliveryAdmin(text:  "Action",flex: 2)
                  
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
                          width: 870,
                          height: 45,
                          child: Row(
                           children: [ 
                           DeliveryAdminListContainers(text:  '${index+1}',flex: 1),
                           const DeliveryAdminListContainers(text:  "THI51685326589",flex: 3,),
                           const DeliveryAdminListContainers(text:  "Testing",flex: 2,),
                           const DeliveryAdminListContainers(text:  "10:00",flex: 1,),
                           const DeliveryAdminListContainers(text:  "40 Kg",flex: 1,),
                           const DeliveryAdminListContainers(text:  "5000",flex: 2,),
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



