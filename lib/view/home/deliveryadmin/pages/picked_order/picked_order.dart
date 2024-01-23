import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
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
          child: const Icon(Icons.arrow_back)),
          title: GoogleLoraWidgets(text: "Picked Orders",fontsize: 19,color: cWhite,fontWeight: FontWeight.bold,),
      ),
      body : SingleChildScrollView(
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
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return  const SizedBox(
                      width: 870,
                      height: 45,
                      child: Row(
                                      children: [ 
                       DeliveryAdminListContainers(text:  '1',flex: 1),
                       DeliveryAdminListContainers(text:  "THI51685326589",flex: 3,),
                       DeliveryAdminListContainers(text:  "Testing",flex: 2,),
                       DeliveryAdminListContainers(text:  "10:00",flex: 1,),
                       DeliveryAdminListContainers(text:  "40 Kg",flex: 1,),
                       DeliveryAdminListContainers(text:  "5000",flex: 2,),
                       DeliveryAdminListContainers(text:  "Action",flex: 2,),
                      
                                      ],
                                    ),
                    );
                  },
                   separatorBuilder: (context, index) => const SizedBox(height: 1,), 
                   itemCount: 7),
              ),
              
            ],
          )),
      ),
    );
  }
}