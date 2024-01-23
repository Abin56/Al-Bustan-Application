import 'package:canteen_productadd_application/view/colors/colors.dart';
import 'package:canteen_productadd_application/view/fonts/google_lora.dart';
import 'package:canteen_productadd_application/view/fonts/google_philosopher.dart';
import 'package:canteen_productadd_application/view/fonts/google_poppins.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/create_order/create_order.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/delivery_order/delivery_orders.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/delivery_request/delivery_request.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/deliveryadmin.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/final_orders/final_orders.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/pending_order/pending_order.dart';
import 'package:canteen_productadd_application/view/home/deliveryadmin/pages/picked_order/picked_order.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/add_product/list%20products/product_list.dart';
import 'package:canteen_productadd_application/view/home/employee/pages/delivery_management/delivery_Histroy/deliveryHistory_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class DeliveryAdminNavBar extends StatefulWidget {
  const DeliveryAdminNavBar({super.key});

  @override
  State<DeliveryAdminNavBar> createState() => _DeliveryAdminNavBarState();
}

class _DeliveryAdminNavBarState extends State<DeliveryAdminNavBar> {
  int _selectedIndex = 0;
  final TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const DeliveryAdminHomePage(),
    //ProductList(),
    const DeliveryHistoryPage(),
    ProductList()
    // Text(
    //   'Delivery',
    //   style: optionStyle,
    // ),
  
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        width: 250,
        child: ListView(
         padding: EdgeInsets.zero,
         children: [
         DrawerHeader(
          decoration: const BoxDecoration(
          color: themeColorBlue,
         ),
         child: Center(child: GoogleLoraWidgets(text: "DELIVERY ADMIN",fontsize: 18,color: cWhite,fontWeight: FontWeight.bold,)
         ),
        ),
       ListTile(
        title: SizedBox(
          height: 45,
          width: double.infinity,
          //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
              Image.asset("images/dashboard.png",width: 18,height: 18,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: " Dashboard", fontsize: 13,fontWeight: FontWeight.bold,),
                ),
                 const Spacer(),
                
              ],
            )
          )),
        onTap: () {
        // Get.to(const DeliveryAdminHomePage())  ;
        },
      ),
      ListTile(
        
        title:  SizedBox(
          height: 45,
          width: double.infinity,
          //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
               Image.asset("images/add-product.png",width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: ' Create Order', fontsize: 13,fontWeight: FontWeight.bold,),
                ), 
              ],
            ),
          )),
        onTap: () {
          Get.to(const DeliveryAdminCreateOrderPage());
        },
      ),
      ListTile(
        title:SizedBox(
          height: 45,
          width: double.infinity,
          //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              children: [
               Image.asset("images/package.png",width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: ' Final Order', fontsize: 13,fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          )), 
        onTap: () {
         Get.to(const DeliveryAdminFinalOrderPage());
        },
      ),
       ListTile(
        title:SizedBox(
          height: 45,
          width: double.infinity,
          //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              children: [
                 Image.asset("images/delivery-man.png",width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: ' Delivery Request', fontsize: 13,fontWeight: FontWeight.bold,),
                ), 
              ],
            ),
          )),  
        onTap: () {
          Get.to(const DeliveryAdminDeliveryRequestPage());
        },
      ),
       ListTile(
        title:SizedBox(
          height: 45,
          width: double.infinity,
         // decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              children: [
                 Image.asset("images/take-away.png",width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: ' Picked Order', fontsize: 13,fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          )),   
        onTap: () {
          Get.to(const DeliveryAdminPickedOrderPage());
        },
      ),
       ListTile(
        title: SizedBox(
          height: 45,
          width: double.infinity,
         // decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              children: [
                 Image.asset('images/package-delivery.png',width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: ' Delivery Order', fontsize: 13,fontWeight: FontWeight.bold,),
                ), 
              ],
            ),
          )), 
        onTap: () {
          Get.to(const DeliveryAdminDeliveryOrderPage());
        },
      ),
       ListTile(
        title:SizedBox(
          height: 45,
          width: double.infinity,
          //decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: cGrey))),
         
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              children: [
                Image.asset("images/package _time.png",width: 25,height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GooglePhilosopherWidgets(text: ' Pending Order', fontsize: 13,fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          )),   
        onTap: () {
          Get.to(const DeliveryAdminPendingOrderPage());
        },
      ),
      
    ],
  ),
      ),
      appBar: AppBar(
        elevation: 20,
        backgroundColor: themeColorBlue,
        title: GooglePoppinsWidgets(
          text: 'Al-Bustan',
          fontsize: 25,
          fontWeight: FontWeight.bold,
          color: cWhite,
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Delivery',
                ),
                GButton(
                  icon: LineIcons.history,
                  text: 'History',
                ),
                // GButton(
                //   icon: LineIcons.user,
                //   text: 'Profile',
                // ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
