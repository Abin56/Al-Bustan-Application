import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/create_order/go_to_cart.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
import 'package:flutter/material.dart';

class DeliveryAdminCreateOrderPage extends StatelessWidget {
  const DeliveryAdminCreateOrderPage({super.key});

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
          title: GoogleLoraWidgets(text: "Create Orders",fontsize: 19,color: cWhite,fontWeight: FontWeight.bold,),
      ),
      body:   SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 870,
          height: 700,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextFormField(decoration: const InputDecoration(border: OutlineInputBorder(),hintText: "🔍Search"),)),
              const Row(
                children: [ 
                   HeaderOfDeliveryAdmin(text: "No.",flex: 1),
                   HeaderOfDeliveryAdmin(text: "Product Name",flex: 3),
                   HeaderOfDeliveryAdmin(text: "Quantity",flex: 2),
                   HeaderOfDeliveryAdmin(text: "In Price",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Out Price",flex: 2),
                   HeaderOfDeliveryAdmin(text:  "Action",flex: 1)
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
                       DeliveryAdminListContainers(text:  "40 Kg",flex: 2,),
                       DeliveryAdminListContainers(text:  "5001",flex: 2,),
                       DeliveryAdminListContainers(text:  "5000",flex: 2,),
                       DeliveryAdminListContainers(text:  "🛒",flex: 1,),
                      ],
                      ),
                    );
                  },
                   separatorBuilder: (context, index) => const SizedBox(height: 1,), 
                   itemCount: 17),
              ),
           Row(
             children: [
               Container(
                width: 110,
                height: 32,
                color: Colors.blue,
                child: Center(child: GestureDetector(
                  onTap: (){
                    goToCartFunction(context);
                  },
                  child: GoogleFirasansWidgets(text: "Go To Cart", fontsize: 13,color: cWhite,fontWeight: FontWeight.bold,))),
               ),
             ],
           )
            ],
          )),
      ),
    );
  }
}