import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_fira_sans.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/widgets/delivery_list/delivery_list_show.dart';
import 'package:flutter/material.dart';



goToCartFunction(BuildContext context){
      showModalBottomSheet(
            context: context,
            builder: (builder){
              return  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 400,
          width: 550,
         // color: Colors.blue,
          child: Column(
            children: [
              Row(
                children: [ 
                  const BackButton(),
                  GoogleFirasansWidgets(text: "CART", fontsize: 15,fontWeight: FontWeight.w500,),
                ],
              ),
              const Row(
                children: [
                  HeaderOfDeliveryAdmin(text: "No.",flex: 1),
                       HeaderOfDeliveryAdmin(text: "Product Name",flex: 3),
                       HeaderOfDeliveryAdmin(text: "Quantity",flex: 3),
                       HeaderOfDeliveryAdmin(text: "Available Qty",flex: 2),
                       HeaderOfDeliveryAdmin(text: "Amount",flex: 2),
                       
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return   SizedBox(
                      width: 590,
                      height: 45,
                      child: Row(
                        children: [ 
                        AlBustanTableViewApp(text:  '${index+1}',flex: 1,color: const Color.fromARGB(255, 241, 232, 232)),
                       const AlBustanTableViewApp(text:  "THI51685326589",flex: 3,color: Color.fromARGB(255, 241, 232, 232)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             GestureDetector(
                                 onTap: () {
                                     //cartCtr.lessQuantity(cartData);
                                      },
                                 child: Container(
                                    width: 30,
                                     height: 30,
                                     decoration: BoxDecoration(
                                      color: cGrey,
                                      borderRadius: BorderRadius.circular(10),),
                                      child: Center(
                                         child: GooglePoppinsWidgets( text: '-', fontsize: 16),
                                          ),
                                       ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                   height: 30,
                                   width: 70,
                                   child: TextField(
                                                //controller: controllers[index],
                                         decoration: InputDecoration(
                                          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),), ),
                                          onChanged: (value) {
                                                  // cartCtr.onChangeFuction(
                                                  //     cartData, value);
                                           },
                                          keyboardType: TextInputType.number,
                                        ),
                                   ),
                                 ),
                                  GestureDetector(
                                   onTap: () {
                                       // cartCtr.addQuantity(cartData);
                                     },
                                    child: Container(
                                       width: 30,
                                       height: 30,
                                       decoration: BoxDecoration(
                                          color: cGrey,
                                          borderRadius:BorderRadius.circular(10), ),
                                          child: Center( child: GooglePoppinsWidgets( text: '+', fontsize: 16),),
                                     ),
                                  ),
                              ],
                             ),
                       const AlBustanTableViewApp(text:  "40 Kg",flex: 2,color: Color.fromARGB(255, 241, 232, 232)),
                      // const AlBustanTableViewApp(text:  "5001",flex: 2,color: Color.fromARGB(255, 241, 232, 232)),
                       const AlBustanTableViewApp(text:  "5000",flex: 2,color: Color.fromARGB(255, 241, 232, 232)),
                     
                      ],
                      ),
                    );
                  },
                   separatorBuilder: (context, index) => const SizedBox(height: 1,), 
                   itemCount: 17),
              ),
              Container(
                width: 120,
                height: 40,
                color: themeColorBlue,
                child: Center(child: GoogleFirasansWidgets(text: "OK", fontsize: 13,color: cWhite,fontWeight: FontWeight.w500,)),
              )
            ],
          ),
        ),
      );
            }
        );
}