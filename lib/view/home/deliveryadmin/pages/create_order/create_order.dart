import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/create_order/go_to_cart.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          child: const Icon(Icons.arrow_back,color: cWhite,)),
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
                   HeaderOfDeliveryAdmin(text: "Company",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Quantity",flex: 2),
                   HeaderOfDeliveryAdmin(text: "In Price",flex: 2),
                   HeaderOfDeliveryAdmin(text: "Out Price",flex: 2),
                   HeaderOfDeliveryAdmin(text:  "Action",flex:1)
                  
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("AllProductStockCollection")
                  .snapshots(),
                  builder: (context, snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: GooglePoppinsWidgets(
                              text: "No data", fontsize: 15),
                        );
                      } else if (!snapshot.hasData) {
                        return Center(
                          child: GooglePoppinsWidgets(
                              text: "No data", fontsize: 15),
                        );
                      } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                         final data = snapshot.data!.docs[index];
                        return   SizedBox(
                          width: 900,
                          height: 45,
                          child: Row(
                            children: [ 
                           DeliveryAdminListContainers(text:  '${index+1}',flex: 1),
                            DeliveryAdminListContainers(text:  data['productname'],flex: 3,),
                            DeliveryAdminListContainers(text:  data['companyName'],flex: 2,),
                            const DeliveryAdminListContainers(text: "40 Kg",flex: 2,),
                            const DeliveryAdminListContainers(text:  "40 Kg",flex: 2,),
                            const DeliveryAdminListContainers(text:  "5000",flex: 2,),
                            const DeliveryAdminListContainers(text:  "🛍️",flex: 1,),
                          
                             ],
                           ),
                        );
                      },
                       separatorBuilder: (context, index) => const SizedBox(height: 1,), 
                       itemCount: snapshot.data!.docs.length,);
                  }
                  }
                ),
              ),  
           Row(
             children: [
               Container(
                width: 110,
                height: 32,
                color: Colors.blue,
                child: Center(child: GestureDetector(
                  onTap: ()async{
                   await goToCartFunction(context);
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